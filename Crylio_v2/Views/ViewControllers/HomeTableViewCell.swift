//
//  HomeTableViewCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    lazy var backgroundBox = RoundedCornersView()
    
    lazy var iconImageView = UIImageView()
    
    lazy var symbolLabel = UILabel()
    lazy var nameLabel = UILabel()
    
    lazy var priceLabel = UILabel()
    lazy var changeLabel = UILabel()
    
    lazy var balanceLabel = UILabel()
    lazy var amountLabel = UILabel()
    
        
    var crypto: Cryptocurrency? {
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func commonInit() {
                        
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        backgroundBox.backgroundColor = AppColors.background.secondary
        
        backgroundBox.layer.cornerRadius = 10
        
        symbolLabel.font = symbolLabel.font.withSize(17)
        
        nameLabel.textColor = .systemGray2
        nameLabel.textAlignment = .left
        nameLabel.font = nameLabel.font.withSize(15)
        
        balanceLabel.textAlignment = .right
        balanceLabel.font = balanceLabel.font.withSize(17)
        
        amountLabel.textColor = .systemGray2
        amountLabel.textAlignment = .right
        amountLabel.font = amountLabel.font.withSize(15)
        
        priceLabel.textAlignment = .right
        priceLabel.font = priceLabel.font.withSize(17)
        
        changeLabel.textAlignment = .right
        changeLabel.font = amountLabel.font
        
        contentView.addSubview(backgroundBox)
        backgroundBox.addSubview(iconImageView)
        backgroundBox.addSubview(symbolLabel)
        backgroundBox.addSubview(nameLabel)
        backgroundBox.addSubview(balanceLabel)
        backgroundBox.addSubview(amountLabel)
        backgroundBox.addSubview(priceLabel)
        backgroundBox.addSubview(changeLabel)
    }
    
    private func initValues() {
        
        if let crypto = self.crypto {
            
            DispatchQueue.main.async { self.iconImageView.setImage(from: crypto.iconURL) }
            symbolLabel.text = crypto.symbol
            nameLabel.text = crypto.name
            balanceLabel.text = crypto.balanceToString()
            amountLabel.text = crypto.amountToString()
            priceLabel.text = crypto.priceToString()
            changeLabel.attributedText = changeLabel.getPercentMutableString(value: crypto.change, colors: true)
        }
    }
    
}


// MARK: - Constraints

extension HomeTableViewCell {
    
    override func layoutIfNeeded() {
        
        backgroundBox.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel)
            make.bottom.equalToSuperview().inset(12)
            make.width.equalTo(100)
            make.height.equalTo(18)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.centerX).offset(30)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.right.equalTo(priceLabel)
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(100)
            make.height.equalTo(18)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.right.equalTo(balanceLabel)
            make.bottom.equalToSuperview().inset(12)
            make.width.equalTo(100)
            make.height.equalTo(18)
        }
        
        super.layoutIfNeeded()
    }
}
