//
//  CryptoTransactionsCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 22/03/2021.
//

import UIKit


class CryptoTransactionCell: UITableViewCell {
    
    lazy var icon = UIImageView()
    
    lazy var transactionType = UILabel()
    lazy var amount = UILabel()
    lazy var exchange = UILabel()
    lazy var worth = UILabel()
    lazy var date = UILabel()
    
    lazy var separator = UIView()
    
    var transaction: Transaction! {
        didSet {
            
            updateValues()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    
    private func commonInit() {
        
        transactionType.font = .systemFont(ofSize: 17, weight: .medium)
        
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
        addSubview(transactionType)
        addSubview(amount)
        addSubview(exchange)
        addSubview(worth)
        addSubview(date)
        addSubview(separator)
    }
    
    func updateValues() {
        
        switch transaction.transactionType {
        
        case .sell:
            icon.image = UIImage(named: "sellIcon")
        case .buy:
            icon.image = UIImage(named: "buyIcon")
        default:
            icon.image = UIImage(named: "transferIcon")
        }
        
        transactionType.text = transaction.transactionType.rawValue
        amount.text = amountFormat(transaction.amount)
        exchange.text = "via " + transaction.exchange
        worth.text = usdFormat(transaction.worth)
        date.text = transaction.dateString
        
        switch transaction.transactionType {
        case .sell:
            transactionType.textColor = .systemRed
            amount.textColor = .systemRed
            amount.text = "- " + amount.text!
        case .buy:
            transactionType.textColor = .systemGreen
            amount.textColor = .systemGreen
        case .transferIn:
            transactionType.textColor = .systemOrange
            amount.textColor = .systemOrange
        case .transferOut:
            transactionType.textColor = .systemOrange
            amount.textColor = .systemOrange
        }
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(29)
        }
        
        transactionType.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(transactionType.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        exchange.snp.makeConstraints { make in
            make.left.equalTo(transactionType.snp.right).offset(5)
            make.centerY.equalTo(transactionType)
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
            make.left.equalTo(transactionType)
            make.top.equalTo(transactionType.snp.bottom).offset(5)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
