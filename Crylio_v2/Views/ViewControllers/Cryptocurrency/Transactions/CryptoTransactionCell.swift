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
    
    lazy var transactionTypeCircle = CircleView()
    lazy var transactionType = UILabel()
    lazy var amount = UILabel()
    lazy var exchange = UILabel()
    lazy var worth = UILabel()
    lazy var date = UILabel()
    lazy var filledStatusBox = RoundedCornersView()
    lazy var filledStatus = UILabel()
        
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
        bgView.backgroundColor = AppColors.background.secondary
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 7
        
        transactionType.font = .systemFont(ofSize: 17)
        
        exchange.font = .systemFont(ofSize: 15)
        exchange.textColor = .systemGray
        
        amount.textAlignment = .right
        amount.font = .systemFont(ofSize: 15)
        
        date.textColor = .systemGray
        date.font = .systemFont(ofSize: 13)
        
        worth.textAlignment = .right
        worth.font = .systemFont(ofSize: 13)
        
        filledStatusBox.layer.cornerRadius = 3
        filledStatusBox.backgroundColor = .systemGreen
        filledStatusBox.alpha = 0.15
        
        filledStatus.textAlignment = .center
        filledStatus.font = .systemFont(ofSize: 13)
        filledStatus.textColor = .systemGreen
                
        contentView.addSubview(bgView)
        bgView.addSubview(transactionTypeCircle)
        bgView.addSubview(transactionType)
        bgView.addSubview(amount)
        bgView.addSubview(exchange)
        bgView.addSubview(worth)
        bgView.addSubview(date)
        bgView.addSubview(filledStatusBox)
        bgView.addSubview(filledStatus)
    }
    
    func updateValues() {
        
        transactionType.text = transaction.transactionType.rawValue
        filledStatus.text = transaction.status.rawValue
        
        exchange.text =  "via " + transaction.exchange
        if transaction.transactionType == .transferOut || transaction.transactionType == .transferIn {
            exchange.text = "to " + transaction.exchange
        }
        exchange.setSpannedColor(fullText:  exchange.text!, changeText: transaction.exchange, color: .label)

        
        worth.text = usdFormat(transaction.worth)
        
        amount.text =  amountFormat(transaction.amount) + "/" + amountFormat(transaction.amountExecuted)
        amount.setSpannedColor(fullText:  amount.text!, changeText: "/" + amountFormat(transaction.amountExecuted), color: .systemGray)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY HH:MM:ss"
        date.text = dateFormatter.string(from: transaction.time)

        
        switch transaction.transactionType {
        case .marketSell:
            transactionTypeCircle.backgroundColor = .systemRed
        case .marketBuy:
            transactionTypeCircle.backgroundColor = .systemGreen
        case .limitBuy:
            transactionTypeCircle.backgroundColor = .systemGreen
        case .limitSell:
            transactionTypeCircle.backgroundColor = .systemRed
        case .transferIn:
            transactionTypeCircle.backgroundColor = .systemBlue
        case .transferOut:
            transactionTypeCircle.backgroundColor = .systemBlue
        }
        
        switch transaction.status {
        case .filled:
            filledStatusBox.backgroundColor = .systemGreen
            filledStatus.textColor = .systemGreen
        case .sent:
            filledStatusBox.backgroundColor = .systemGreen
            filledStatus.textColor = .systemGreen
        case .canceled:
            filledStatusBox.backgroundColor = .systemRed
            filledStatus.textColor = .systemRed
        default:
            filledStatusBox.backgroundColor = .systemGray
            filledStatus.textColor = .systemGray
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
        
        transactionTypeCircle.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(20)
            make.height.width.equalTo(8)
        }
        
        transactionType.snp.makeConstraints { make in
            make.left.equalTo(transactionTypeCircle.snp.right).offset(8)
            make.centerY.equalTo(transactionTypeCircle)
            make.width.equalTo(transactionType.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        exchange.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(transactionType.snp.bottom).offset(9)
            make.width.equalTo(exchange.intrinsicContentSize.width)
            make.height.equalTo(18)
        }
        
        date.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(exchange.snp.bottom).offset(4)
            make.width.equalTo(date.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        filledStatusBox.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(transactionType)
            make.width.equalTo(filledStatus.intrinsicContentSize.width + 8)
            make.height.equalTo(20)
        }
        
        filledStatus.snp.makeConstraints { make in
            make.center.equalTo(filledStatusBox)
            make.height.width.equalTo(filledStatusBox)
        }
        
        amount.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(exchange)
            make.width.equalTo(amount.intrinsicContentSize.width)
            make.height.equalTo(18)
        }
            
        worth.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(date)
            make.width.equalTo(worth.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        super.updateConstraints()
    }
    
}
