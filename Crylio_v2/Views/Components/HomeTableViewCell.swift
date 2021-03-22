//
//  HomeTableViewCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit


class HomeTableViewCell: UITableViewCell {
    
    lazy var icon = UIImageView()
    
    lazy var symbol = UILabel()
    lazy var name = UILabel()
    lazy var balance = UILabel()
    lazy var amount = UILabel()
    lazy var price = UILabel()
    lazy var change = PriceChangeBoxView()
    
    lazy var separator = UIView()
    
    var crypto : Cryptocurrency? {
            didSet {
                icon.image = UIImage(named: "btc")
                symbol.text = crypto?.symbol
                name.text = crypto?.name
                balance.text = crypto?.balanceToString()
                amount.text = crypto?.amountToString() 
                price.text = crypto?.priceToString()
                change.change.text = crypto?.changeToString()
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
        
        symbol.font = symbol.font.withSize(17)
        
        name.textColor = .systemGray2
        name.textAlignment = .left
        name.font = name.font.withSize(15)
        
        balance.textAlignment = .right
        balance.font = balance.font.withSize(17)
        
        amount.textColor = .systemGray2
        amount.textAlignment = .right
        amount.font = amount.font.withSize(15)
        
        price.textAlignment = .right
        price.font = price.font.withSize(17)
        
        
        separator.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.24, alpha: 0.3)
        
        addSubview(icon)
        addSubview(symbol)
        addSubview(name)
        addSubview(balance)
        addSubview(amount)
        addSubview(price)
        addSubview(change)
        addSubview(separator)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(29)
        }
        
        symbol.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(symbol)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        price.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
        change.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(name)
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
        
        balance.snp.makeConstraints { make in
            make.right.equalTo(change.snp.left).offset(-62)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
        amount.snp.makeConstraints { make in
            make.right.equalTo(balance)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(110)
            make.height.equalTo(25)
        }
        
        separator.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        super.updateConstraints()
    }
    
}
