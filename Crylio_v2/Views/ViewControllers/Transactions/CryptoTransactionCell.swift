//
//  CryptoTransactionsCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 22/03/2021.
//

import UIKit


class CryptoTransactionCell: UITableViewCell {
    
    static let reuseId = "TransactionCell"

    
    let bgView = UIView()
        
    lazy var transactionType = UILabel()
    lazy var amount = UILabel()
    lazy var exchange = UILabel()
    lazy var worth = UILabel()
    lazy var date = UILabel()
        
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
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        transactionType.font = .systemFont(ofSize: 17, weight: .medium)
        
        exchange.font = .systemFont(ofSize: 17)
        
        amount.textAlignment = .right
        amount.font = .systemFont(ofSize: 17, weight: .medium)
        
        date.textColor = .systemGray
        date.font = .systemFont(ofSize: 13)
        
        worth.textColor = .systemGray
        worth.textAlignment = .right
        worth.font = .systemFont(ofSize: 15)
                
        contentView.addSubview(bgView)
        bgView.addSubview(transactionType)
        bgView.addSubview(amount)
        bgView.addSubview(exchange)
        bgView.addSubview(worth)
        bgView.addSubview(date)
    }
    
    func updateValues() {
        
        transactionType.text = transaction.transactionType.rawValue
        
        exchange.text = "via " + transaction.exchange
        
        if transaction.transactionType == .transferOut || transaction.transactionType == .transferIn {
            exchange.text = "to " + transaction.exchange
        }
        
        worth.text = usdFormat(transaction.worth)
        amount.text = amountFormat(transaction.amount) + " \(transaction.asset)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY HH:MM:ss"
        date.text = dateFormatter.string(from: transaction.time)

        
        switch transaction.transactionType {
        case .marketSell:
            transactionType.textColor = .systemRed
        case .marketBuy:
            transactionType.textColor = .systemGreen
        case .limitBuy:
            transactionType.textColor = .systemGreen
        case .limitSell:
            transactionType.textColor = .systemRed
        case .transferIn:
            transactionType.textColor = .systemOrange
        case .transferOut:
            transactionType.textColor = .systemOrange
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

extension CryptoTransactionCell {
    
    
    override func updateConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
            make.height.equalToSuperview()
        }
        
        transactionType.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
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
            make.top.equalTo(transactionType.snp.bottom).offset(10)
            make.width.equalTo(date.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        worth.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(date)
            make.width.equalTo(worth.intrinsicContentSize.width)
            make.height.equalTo(18)
        }
        
        super.updateConstraints()
    }
    
}
