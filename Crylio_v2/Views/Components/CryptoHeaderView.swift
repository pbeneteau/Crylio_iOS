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
    
    lazy var price = UILabel()
    lazy var changeBox = PriceChangeBox()
    
    lazy var timeframeButton = UIButton()
    lazy var timeframeDropdownView = DropDown()
    
    lazy var watchButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(name: String, symbol: String, price: Float, change: Float, iconName: String) {
        super.init(frame: CGRect.zero)
        
        self.nameLabel.text = name
        self.symbolLabel.text = symbol
        self.price.text = usdFormat(price)
        self.changeBox = PriceChangeBox(change: change)
        self.icon.image = UIImage(named: iconName)
                        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        symbolLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        price.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        changeBox.change.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        symbolLabel.textColor = AppColors.label.secondary
        
        
        timeframeDropdownView.backgroundColor = .systemGray4
        timeframeDropdownView.selectionBackgroundColor = .systemGray5
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
        
        watchButton.layer.cornerRadius = 7
        watchButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        watchButton.setTitle("Watch", for: .normal)
        watchButton.setTitleColor(.systemBlue, for: .normal)
        watchButton.setTitle("Unwatch", for: .selected)
        watchButton.setTitleColor(.label, for: .selected)
        watchButton.addTarget(self, action: #selector(self.watchButtonAction(sender:)), for: .touchUpInside)
        
        watchButton.isSelected = false
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(price)
        addSubview(changeBox)
        addSubview(icon)
        addSubview(timeframeButton)
        addSubview(watchButton)
        
        setNeedsUpdateConstraints()
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
    
    override func updateConstraints() {
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(5)
            make.height.width.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15)
            make.top.equalTo(icon)
            make.height.equalTo(29)
            make.width.equalTo(nameLabel.intrinsicContentSize)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15)
            make.bottom.equalTo(icon)
            make.height.equalTo(20)
            make.width.equalTo(symbolLabel.intrinsicContentSize)
        }
        
        price.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(29)
            make.width.equalTo(price.intrinsicContentSize)
        }
        
        changeBox.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(symbolLabel)
            make.height.equalTo(20)
            make.width.equalTo(changeBox.change.intrinsicContentSize.width + 25)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeframeButton.backgroundColor = .clear
        timeframeButton.layer.cornerRadius = 7
        timeframeButton.layer.borderWidth = 1
        timeframeButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        timeframeDropdownView.bottomOffset = CGPoint(x: 0, y:(timeframeDropdownView.anchorView?.plainView.bounds.height)!)
        
     

    }

}
