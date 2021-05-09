//
//  CryptoDetailHeaderView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import DropDown


class CryptoHeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    lazy var symbolLabel = UILabel()
    lazy var icon = UIImageView()
    
    lazy var priceLabel = UILabel()
    lazy var changeBox = PriceChangeBox()
    
    lazy var timeframeButton = UIButton()
    lazy var timeframeDropdownView = DropDown()
    
    lazy var watchButton = UIButton()
    
    var crypto: Cryptocurrency! {
        didSet {
            initValues()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        symbolLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        priceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        changeBox.changeLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        symbolLabel.textColor = AppColors.label.secondary
        
        priceLabel.textAlignment = .right
        
        timeframeDropdownView.cornerRadius = 10
        timeframeDropdownView.textColor = AppColors.label.primary
        timeframeDropdownView.backgroundColor = AppColors.background.tertiary
        timeframeDropdownView.selectionBackgroundColor = .systemBlue.withAlphaComponent(0.2)
        timeframeDropdownView.dimmedBackgroundColor = .black.withAlphaComponent(0.3)
        timeframeDropdownView.setupCornerRadius(10)
        timeframeDropdownView.dataSource = ["1 hour", "12 hours", "1 days", "3 days", "1 weeks", "1 months", "3 months", "1 years", "All"]
        timeframeDropdownView.anchorView = timeframeButton
        timeframeDropdownView.bottomOffset = CGPoint(x: 0, y:(timeframeDropdownView.anchorView?.plainView.bounds.height)!)
        timeframeDropdownView.shadowColor = .systemGray6
        timeframeDropdownView.selectRow(2)
        timeframeDropdownView.selectionAction = { [unowned self] (index: Int, timeframe: String) in timeframeSelected(index: index, timeframe: timeframe) }

        timeframeButton.titleLabel?.font = .systemFont(ofSize: 15)
        timeframeButton.setTitle("1 day", for: .normal)
        timeframeButton.setTitleColor(.systemBlue, for: .normal)
        timeframeButton.addTarget(self, action: #selector(self.timeframeButtonAction(sender:)), for: .touchUpInside)
        timeframeButton.backgroundColor = .clear
        timeframeButton.layer.cornerRadius = 10
        timeframeButton.layer.borderWidth = 1
        timeframeButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        watchButton.layer.cornerRadius = 10
        watchButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        watchButton.setTitle("Watch", for: .normal)
        watchButton.setTitleColor(.systemBlue, for: .normal)
        watchButton.setTitle("Unwatch", for: .selected)
        watchButton.setTitleColor(.label, for: .selected)
        watchButton.addTarget(self, action: #selector(self.watchButtonAction(sender:)), for: .touchUpInside)
        
        watchButton.isSelected = false
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(priceLabel)
        addSubview(changeBox)
        addSubview(icon)
        addSubview(timeframeButton)
        addSubview(watchButton)
    }
    
    func initValues() {
        
        self.nameLabel.text = crypto.name
        self.symbolLabel.text = crypto.symbol
        self.priceLabel.attributedText = priceLabel.getDollarMutableString(value: crypto.price)
        self.changeBox.change = crypto.change
        self.icon.image = UIImage(named: crypto.iconName)
    }
    
    @objc func timeframeButtonAction(sender: UIButton!) {
        
        timeframeDropdownView.show()
    }
    
    
    func timeframeSelected(index: Int, timeframe: String) {
        
        print("Selected timeframe: \(timeframe) at index: \(index)")
        timeframeButton.setTitle(timeframe, for: .normal)
    }
    
    
    @objc func watchButtonAction(sender: UIButton!) {
                
        if sender.isSelected {
            // unwatched
            watchButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
            watchButton.layer.borderWidth = 0
            sender.isSelected = false
        } else {
            // watched
            watchButton.backgroundColor = .clear
            watchButton.layer.borderWidth = 1
            watchButton.layer.borderColor = AppColors.label.secondary.withAlphaComponent(0.5).cgColor
            sender.isSelected = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        changeBox.snp.remakeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(symbolLabel)
            make.height.equalTo(20)
            make.width.equalTo(changeBox.changeLabel.intrinsicContentSize.width + 25)
        }
    }
    
}


// CONSTRAINTS

extension CryptoHeaderView {
    
    override func updateConstraints() {
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(5)
            make.height.width.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15)
            make.right.equalTo(self.snp.centerX).inset(8)
            make.top.equalTo(icon)
            make.height.equalTo(29)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15)
            make.right.equalTo(self.snp.centerX).inset(8)
            make.bottom.equalTo(icon)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(self.snp.centerX).offset(8)
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(29)
        }
        
        changeBox.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(symbolLabel)
            make.height.equalTo(20)
        }
        
        timeframeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(34)
        }
        
        watchButton.snp.makeConstraints { make in
            make.left.equalTo(timeframeButton.snp.right).offset(15)
            make.centerY.equalTo(timeframeButton)
            make.width.equalTo(100)
            make.height.equalTo(34)
        }
        
        super.updateConstraints()
    }

}
