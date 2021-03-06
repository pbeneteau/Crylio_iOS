//
//  CryptoDetailHeaderView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import DropDown


class CryptoDetailHeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    lazy var symbolLabel = UILabel()
    lazy var typeLabel = UILabel()
    lazy var icon = UIImageView()
    
    lazy var timeframeButton = UIButton()
    lazy var timeframeDropdownView = DropDown()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(name: String, symbol: String, type: String, icon: UIImage) {
        super.init(frame: CGRect.zero)
        
        self.nameLabel.text = name
        self.symbolLabel.text = symbol
        self.typeLabel.text = type
        self.icon.image = icon
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        symbolLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        typeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        nameLabel.textColor = .label
        symbolLabel.textColor = .label
        typeLabel.textColor = .systemGray
        
        timeframeDropdownView.backgroundColor = .systemGray4
        timeframeDropdownView.textColor = .label
        timeframeDropdownView.selectionBackgroundColor = .systemGray5
        timeframeDropdownView.setupCornerRadius(7)
        timeframeDropdownView.dataSource = ["1h", "12h", "1d", "3d", "1w", "1m", "3m", "1y", "All"]
        timeframeDropdownView.anchorView = timeframeButton
        timeframeDropdownView.bottomOffset = CGPoint(x: 0, y:(timeframeDropdownView.anchorView?.plainView.bounds.height)!)
        timeframeDropdownView.shadowColor = .systemGray6
        timeframeDropdownView.selectRow(2)
        
        timeframeDropdownView.selectionAction = { [unowned self] (index: Int, timeframe: String) in timeframeSelected(index: index, timeframe: timeframe) }

        timeframeButton.titleLabel?.font = .systemFont(ofSize: 15)
        timeframeButton.setTitle("1d", for: .normal)
        timeframeButton.setTitleColor(.systemBlue, for: .normal)
        timeframeButton.addTarget(self, action: #selector(self.timeframeButtonAction(sender:)), for: .touchUpInside)
        
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(typeLabel)
        addSubview(icon)
        addSubview(timeframeButton)
    }
    
    @objc func timeframeButtonAction(sender: UIButton!) {
        timeframeDropdownView.show()
        
    }
    
    
    func timeframeSelected(index: Int, timeframe: String) {
        print("Selected timeframe: \(timeframe) at index: \(index)")
        timeframeButton.setTitle(timeframe, for: .normal)
    }
    
    override func updateConstraints() {
        
        timeframeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(34)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(timeframeButton.snp.top).offset(-10)
            make.height.equalTo(17)
            make.width.equalTo(symbolLabel.intrinsicContentSize)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel.snp.right).offset(15)
            make.bottom.equalTo(symbolLabel)
            make.height.equalTo(17)
            make.width.equalTo(typeLabel.intrinsicContentSize)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(symbolLabel.snp.top).offset(-5)
            make.height.equalTo(41)
            make.width.equalTo(nameLabel.intrinsicContentSize)
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.centerY)
            make.height.width.equalTo(38)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeframeButton.backgroundColor = .clear
        timeframeButton.layer.cornerRadius = 7
        timeframeButton.layer.borderWidth = 1
        timeframeButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        timeframeDropdownView.bottomOffset = CGPoint(x: 0, y:(timeframeDropdownView.anchorView?.plainView.bounds.height)!)

    }

}
