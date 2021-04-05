//
//  CryptoOrderCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/03/2021.
//

import UIKit

class CryptoOrderCell: UITableViewCell {
    
    
    lazy var icon = UIImageView()
    
    lazy var orderType = UILabel()
    lazy var amount = UILabel()
    lazy var exchange = UILabel()
    lazy var worth = UILabel()
    lazy var date = UILabel()
    
    lazy var separator = UIView()
    
    var order: Order! {
        didSet {
            
            updateValues()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }

    private func commonInit() {
        
        orderType.font = .systemFont(ofSize: 17, weight: .medium)
        
        exchange.textColor = .systemGray
        exchange.font = .systemFont(ofSize: 17)
        
        amount.textAlignment = .right
        amount.font = .systemFont(ofSize: 17)
        
        date.font = .systemFont(ofSize: 13)
        date.textColor = .systemGray
        
        worth.textAlignment = .right
        worth.font = .systemFont(ofSize: 13, weight: .medium)
        worth.textColor = .systemGray
        
        separator.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.24, alpha: 0.3)
        
        addSubview(icon)
        addSubview(orderType)
        addSubview(amount)
        addSubview(exchange)
        addSubview(worth)
        addSubview(date)
        addSubview(separator)
    }
    
    func updateValues() {
        
        switch order.orderType {
        
        case .marketBuy:
            icon.image = UIImage(named: "sellIcon")
        case .marketSell:
            icon.image = UIImage(named: "buyIcon")
        default:
            icon.image = UIImage(named: "transferIcon")
        }
        
        orderType.text = order.orderType.rawValue
        amount.text = amountFormat(order.amount)
        exchange.text = "via " + order.exchange
        worth.text = usdFormat(order.worth)
        date.text = order.dateString
        
        switch order.orderType {
        case .marketSell:
            orderType.textColor = .systemRed
            amount.textColor = .systemRed
            amount.text = "- " + amount.text!
        case .marketBuy:
            orderType.textColor = .systemGreen
            amount.textColor = .systemGreen
        case .limitBuy:
            orderType.textColor = .systemOrange
            amount.textColor = .systemOrange
        case .limitSell:
            orderType.textColor = .systemOrange
            amount.textColor = .systemOrange
        }
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CryptoOrderCell {
    
    override func updateConstraints() {
        
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(29)
        }
        
        orderType.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(orderType.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        exchange.snp.makeConstraints { make in
            make.left.equalTo(orderType.snp.right).offset(5)
            make.centerY.equalTo(orderType)
            make.width.equalTo(exchange.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        amount.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(exchange)
            make.width.equalTo(amount.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        date.snp.makeConstraints { make in
            make.left.equalTo(orderType)
            make.top.equalTo(orderType.snp.bottom).offset(5)
            make.width.equalTo(date.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        worth.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(date)
            make.width.equalTo(worth.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        separator.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        super.updateConstraints()
    }
    
}
