//
//  CryptoOrderCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/03/2021.
//

import UIKit

class CryptoOrderCell: UITableViewCell {
    
    lazy var orderTypeLabel = UILabel()
    lazy var amountLabel = UILabel()
    lazy var exchangeLabel = UILabel()
    lazy var worthLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var filledStatusBoxView = RoundedCornersView()
    lazy var filledStatusLabel = UILabel()
    
        
    var order: Order! {
        didSet {
            initValues()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    init(order: Order) {
        self.init()
        
        self.order = order
        
        commonInit()
    }

    private func commonInit() {
        
        orderTypeLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        exchangeLabel.font = .systemFont(ofSize: 15)
        exchangeLabel.textColor = .systemGray
        
        amountLabel.textAlignment = .right
        amountLabel.font = .systemFont(ofSize: 15)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13)
        
        worthLabel.textAlignment = .right
        worthLabel.font = .systemFont(ofSize: 13)
        
        filledStatusBoxView.layer.cornerRadius = 3
        filledStatusBoxView.backgroundColor = .systemGreen
        filledStatusBoxView.alpha = 0.15
        
        filledStatusLabel.textAlignment = .center
        filledStatusLabel.font = .systemFont(ofSize: 13)
        filledStatusLabel.textColor = .systemGreen
                
        addSubview(orderTypeLabel)
        addSubview(amountLabel)
        addSubview(exchangeLabel)
        addSubview(worthLabel)
        addSubview(dateLabel)
        addSubview(filledStatusBoxView)
        addSubview(filledStatusLabel)
    }
    
    func initValues() {
        
        orderTypeLabel.text = order.orderType.rawValue
        worthLabel.attributedText = worthLabel.getDollarMutableString(value: order.worth)
        dateLabel.text = order.dateString
        filledStatusLabel.text = order.status.rawValue
        
        amountLabel.text = order.amount.toAmountString() + "/" + order.amount.toAmountString()
        amountLabel.setSpannedColor(fullText:  amountLabel.text!, changeText: "/" + order.amount.toAmountString(), color: .systemGray)
        
        exchangeLabel.text =  "via " + order.exchange
        exchangeLabel.setSpannedColor(fullText:  exchangeLabel.text!, changeText: order.exchange, color: .label)

        switch order.orderType {
        case .marketSell:
            orderTypeLabel.textColor = .systemRed
        case .marketBuy:
            orderTypeLabel.textColor = .systemGreen
        case .limitBuy:
            orderTypeLabel.textColor = .systemGreen
        case .limitSell:
            orderTypeLabel.textColor = .systemRed
        }
        
        switch order.status {
        case .filled:
            filledStatusBoxView.backgroundColor = .systemGreen
            filledStatusLabel.textColor = .systemGreen
        default:
            filledStatusBoxView.backgroundColor = .systemGray
            filledStatusLabel.textColor = .systemGray
        }
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
        
        orderTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(orderTypeLabel.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        exchangeLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(orderTypeLabel.snp.bottom).offset(9)
            make.width.equalTo(exchangeLabel.intrinsicContentSize.width)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(exchangeLabel.snp.bottom).offset(4)
            make.width.equalTo(dateLabel.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        
        filledStatusBoxView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(orderTypeLabel)
            make.width.equalTo(filledStatusLabel.intrinsicContentSize.width + 8)
            make.height.equalTo(20)
        }
        
        filledStatusLabel.snp.makeConstraints { make in
            make.center.equalTo(filledStatusBoxView)
            make.height.width.equalTo(filledStatusBoxView)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(exchangeLabel)
            make.width.equalTo(amountLabel.intrinsicContentSize.width)
            make.height.equalTo(18)
        }
            
        worthLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(dateLabel)
            make.width.equalTo(worthLabel.intrinsicContentSize.width)
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
