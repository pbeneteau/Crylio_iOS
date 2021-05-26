//
//  AddTransactionTableViewCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 25/05/2021.
//

import UIKit

class AddTransactionTableViewCell: UITableViewCell {
    
    static let reuseId = "AddTransactionTableViewCell"
    
    lazy var backgroundBox = RoundedCornersView()
    lazy var titleLabel = UILabel()
    lazy var textField = SearchTextField()
    lazy var prefixSuffixLabel = UILabel()
    
    lazy var enteredValue = ""
    
    var field: Field! {
        didSet {
            initValues()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        backgroundBox.layer.cornerRadius = 7
        backgroundBox.backgroundColor = AppColors.background.tertiary
        
        titleLabel.textColor = AppColors.label.secondary
        titleLabel.font = .systemFont(ofSize: 15)
        
        textField.font = .systemFont(ofSize: 17)
        textField.textAlignment = .right
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.textColor = AppColors.label.primary
        textField.delegate = self
        
        textField.theme = traitCollection.userInterfaceStyle == .dark ? SearchTextFieldTheme.darkTheme(): SearchTextFieldTheme.lightTheme()
        textField.theme.font = .systemFont(ofSize: 17)
        textField.theme.bgColor = .clear
        textField.theme.borderColor = .clear
        textField.theme.cellHeight = 45
        textField.highlightAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17)]
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        
        // Define a results list header
        let header = SearchTextFieldSuggestionsHeader(frame: CGRect(x: 0, y: 0, width: textField.frame.width, height: 38))
        header.title.text = "Suggestions"
        textField.resultsListHeader = header
        
        prefixSuffixLabel.textAlignment = .left
        prefixSuffixLabel.textColor = AppColors.label.secondary
        
        addSubview(backgroundBox)
        backgroundBox.addSubview(titleLabel)
        backgroundBox.addSubview(textField)
        backgroundBox.addSubview(prefixSuffixLabel)
    }
    
    private func initValues() {
        
        titleLabel.text = field.title
        textField.placeholder = field.placeholder
        
        if let value = field.value {
            textField.text = value
        }
        
        if let suggestions = field.suggestions  {
            textField.filterItems(suggestions.map { sugg in
                return SearchTextFieldItem(title: sugg, subtitle: "", image: UIImage(named: sugg.lowercased()))
            })
        }
        
        textField.keyboardType = field.keyboardType
        
        if field.prefix != "" {
            prefixSuffixLabel.text = field.prefix + " "
        }
        
        if field.suffix != "" {
            prefixSuffixLabel.text = " " + field.suffix
        }
    }
    
    
    
}

// MARK: - text field delegate

extension AddTransactionTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            let newPosition = textField.endOfDocument
            print(newPosition)
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
                
        if field.prefix != "" {
            
            prefixSuffixLabel.snp.updateConstraints { make in
                make.right.equalTo(textField).inset(textField.intrinsicContentSize.width)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        enteredValue += string.replacingOccurrences(of: ",", with: ".")
//        textField.text = Float(enteredValue)!.toAmountString()
        return true
    }
}


// MARK: - Constraints

extension AddTransactionTableViewCell {
    
    override func layoutIfNeeded() {
                
        backgroundBox.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.centerY.equalToSuperview()
            make.width.equalTo(titleLabel.intrinsicContentSize.width)
            make.height.equalToSuperview()
        }
        
        if field.suffix != "" {
            
            prefixSuffixLabel.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(13)
                make.centerY.equalToSuperview()
                make.width.equalTo(prefixSuffixLabel.intrinsicContentSize.width)
                make.height.equalToSuperview()
            }
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.snp.right).offset(16)
                make.right.equalTo(prefixSuffixLabel.snp.left).inset(5)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
            
        } else if field.prefix != "" {
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.snp.right).offset(16)
                make.right.equalToSuperview().inset(13)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
            
            prefixSuffixLabel.snp.makeConstraints { make in
                make.right.equalTo(textField).inset(textField.intrinsicContentSize.width)
                make.centerY.equalToSuperview()
                make.width.equalTo(prefixSuffixLabel.intrinsicContentSize.width)
                make.height.equalToSuperview()
            }
        } else {
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.snp.right).offset(16)
                make.right.equalToSuperview().inset(13)
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
        }
        
        super.layoutIfNeeded()
    }
}

extension UIColor {

    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}
