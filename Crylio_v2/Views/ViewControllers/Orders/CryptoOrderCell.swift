//
//  CryptoOrderCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/03/2021.
//

import UIKit

class CryptoOrderCell: UITableViewCell {
    
    lazy var orderType = UILabel()
    lazy var amount = UILabel()
    lazy var exchange = UILabel()
    lazy var worth = UILabel()
    lazy var date = UILabel()
    lazy var filledStatusBox = RoundedCornersView()
    lazy var filledStatus = UILabel()
    
        
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
        
        addSubview(orderType)
        addSubview(amount)
        addSubview(exchange)
        addSubview(worth)
        addSubview(date)
        addSubview(filledStatusBox)
        addSubview(filledStatus)
    }
    
    func updateValues() {
        
        orderType.text = order.orderType.rawValue
        worth.text = usdFormat(order.worth)
        date.text = order.dateString
        filledStatus.text = order.status.rawValue
        
        amount.text =  amountFormat(order.amount) + "/" + amountFormat(order.amount)
        amount.setSpannedColor(fullText:  amount.text!, changeText: "/" + amountFormat(order.amount), color: .systemGray)
        
        exchange.text =  "via " + order.exchange
        exchange.setSpannedColor(fullText:  exchange.text!, changeText: order.exchange, color: .label)

        switch order.orderType {
        case .marketSell:
            orderType.textColor = .systemRed
        case .marketBuy:
            orderType.textColor = .systemGreen
        case .limitBuy:
            orderType.textColor = .systemGreen
        case .limitSell:
            orderType.textColor = .systemRed
        }
        
        switch order.status {
        case .filled:
            filledStatusBox.backgroundColor = .systemGreen
            filledStatus.textColor = .systemGreen
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

extension CryptoOrderCell {
    
    override func updateConstraints() {
        
        orderType.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(orderType.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        exchange.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(orderType.snp.bottom).offset(9)
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
            make.centerY.equalTo(orderType)
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

extension UILabel {
    func setSpannedColor (fullText : String , changeText : String, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        self.attributedText = attribute
    }
}
