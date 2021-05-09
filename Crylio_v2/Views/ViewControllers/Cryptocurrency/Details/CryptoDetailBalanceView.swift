//
//  CryptoDetailBalanceView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 09/05/2021.
//

import UIKit

class CryptoDetailBalanceView: RoundedCornersView {
        
    lazy var iconView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var worthLabel = UILabel()
    lazy var amountLabel = UILabel()
    
    var iconName: String! {
        didSet {
            iconView.image = UIImage(named: iconName)
        }
    }
    
    var symbol: String! {
        didSet {
            titleLabel.text = "\(symbol!) Balance"
        }
    }
    
    var worth: Float! {
        didSet {
            worthLabel.text = worth.toDollarString()
        }
    }
    
    var amount: Float! {
        didSet {
            amountLabel.text = amount.toAmountString(symbol: symbol!)
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
    
    func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = AppColors.background.secondary.cgColor
        
        titleLabel.font = .systemFont(ofSize: 15)
        worthLabel.font = .systemFont(ofSize: 17, weight: .medium)
        amountLabel.font = .systemFont(ofSize: 15)
        
        amountLabel.textColor = AppColors.label.secondary
        
        worthLabel.textAlignment = .right
        amountLabel.textAlignment = .right
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(worthLabel)
        addSubview(amountLabel)
    }
}

// CONSTRAINTS

extension CryptoDetailBalanceView {
    
    override func updateConstraints() {
        
        iconView.snp.makeConstraints { make in
            make.left.top.equalTo(16)
            make.width.height.equalTo(43)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(15)
            make.centerY.equalTo(iconView)
            make.right.equalTo(self.snp.centerX).inset(8)
            make.height.equalTo(18)
        }
        
        worthLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(8)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(8)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        super.updateConstraints()
    }
}
