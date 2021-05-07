//
//  HoldingsStatsView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 11/03/2021.
//

import UIKit

class HoldingsStatsView: UIView {

    lazy var backgroundBox = UIView()
    
    lazy var worth = UILabel()

    
    lazy var averageCostIcon = UIImageView(image: UIImage(named: "dollarIcon"))
    lazy var totalAmountIcon = UIImageView(image: UIImage(named: "databaseIcon"))
    lazy var profitLossIcon = UIImageView(image: UIImage(named: "chartIcon"))
    lazy var percentChangeIcon = UIImageView(image: UIImage(named: "percentIcon"))
    
    lazy var averageCostTitle = UILabel()
    lazy var averageCost = UILabel()
    lazy var totalAmountTitle = UILabel()
    lazy var totalAmount = UILabel()
    lazy var profitLossTitle = UILabel()
    lazy var profitLoss = UILabel()
    lazy var percentChangeTitle = UILabel()
    lazy var percentChange = UILabel()
    
    lazy var separationLine = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(worth:Float,
         averageCost: Float,
         totalAmount: Float,
         profitLoss: Float,
         percentChange: Float) {
        
        super.init(frame: CGRect.zero)
        
        self.worth.text = usdFormat(worth)
        self.averageCost.text = usdFormat(averageCost)
        self.totalAmount.text = amountFormat(totalAmount)
        self.profitLoss.text = usdFormat(profitLoss)
        self.percentChange.text = percentFormat(percentChange)
        
        if percentChange > 0 {
            self.percentChange.textColor = .systemGreen
            self.profitLoss.textColor = .systemGreen
        } else if percentChange < 0 {
            self.percentChange.textColor = .systemRed
            self.profitLoss.textColor = .systemRed
        } else {
            self.percentChange.textColor = .systemGray
            self.profitLoss.textColor = .systemGray
        }
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    
    private func commonInit() {
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = AppColors.background.secondary
        
        backgroundBox.layer.cornerRadius = 7
        
        separationLine.backgroundColor = .systemGray5
                
        averageCostTitle.text = "Average Cost"
        totalAmountTitle.text = "Total Amount"
        profitLossTitle.text = "Profit / Loss"
        percentChangeTitle.text = "Percent Change"
        
        worth.font = .systemFont(ofSize: 28, weight: .medium)
                
        averageCostTitle.font = .systemFont(ofSize: 13)
        averageCost.font = .systemFont(ofSize: 17)
        totalAmountTitle.font = .systemFont(ofSize: 13)
        totalAmount.font = .systemFont(ofSize: 17)
        profitLossTitle.font = .systemFont(ofSize: 13)
        profitLoss.font = .systemFont(ofSize: 17, weight: .medium)
        percentChangeTitle.font = .systemFont(ofSize: 13)
        percentChange.font = .systemFont(ofSize: 17, weight: .medium)
        
        worth.textColor = .label
        
        averageCostTitle.textColor = .systemGray
        averageCost.textColor = .label
        totalAmountTitle.textColor = .systemGray
        totalAmount.textColor = .label
        profitLossTitle.textColor = .systemGray
        percentChangeTitle.textColor = .systemGray
                
        addSubview(backgroundBox)
        
        backgroundBox.addSubview(worth)
        
        backgroundBox.addSubview(averageCostIcon)
        backgroundBox.addSubview(totalAmountIcon)
        backgroundBox.addSubview(profitLossIcon)
        backgroundBox.addSubview(percentChangeIcon)
        
        backgroundBox.addSubview(separationLine)
        
        backgroundBox.addSubview(averageCostTitle)
        backgroundBox.addSubview(averageCost)
        backgroundBox.addSubview(totalAmountTitle)
        backgroundBox.addSubview(totalAmount)
        backgroundBox.addSubview(profitLossTitle)
        backgroundBox.addSubview(profitLoss)
        backgroundBox.addSubview(percentChangeTitle)
        backgroundBox.addSubview(percentChange)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateConstraints() {
        
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        worth.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.width.equalTo(worth.intrinsicContentSize.width)
            make.height.equalTo(28)
        }
        
        averageCostIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(worth.snp.bottom).offset(20)
            make.width.height.equalTo(22)
        }
        averageCostTitle.snp.makeConstraints { make in
            make.left.equalTo(averageCostIcon.snp.right).offset(10)
            make.centerY.equalTo(averageCostIcon)
            make.width.equalTo(averageCostTitle.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        averageCost.snp.makeConstraints { make in
            make.left.equalTo(averageCostTitle)
            make.top.equalTo(averageCostIcon.snp.bottom).offset(5)
            make.width.equalTo(averageCost.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
       
        profitLossIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(averageCost.snp.bottom).offset(15)
            make.width.height.equalTo(22)
        }
        profitLossTitle.snp.makeConstraints { make in
            make.left.equalTo(profitLossIcon.snp.right).offset(10)
            make.centerY.equalTo(profitLossIcon)
            make.width.equalTo(profitLossTitle.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        profitLoss.snp.makeConstraints { make in
            make.left.equalTo(profitLossTitle)
            make.top.equalTo(profitLossIcon.snp.bottom).offset(5)
            make.width.equalTo(profitLoss.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        totalAmountIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(30)
            make.top.equalTo(separationLine)
            make.width.height.equalTo(22)
        }
        totalAmountTitle.snp.makeConstraints { make in
            make.left.equalTo(totalAmountIcon.snp.right).offset(10)
            make.centerY.equalTo(totalAmountIcon)
            make.width.equalTo(totalAmountTitle.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        totalAmount.snp.makeConstraints { make in
            make.left.equalTo(totalAmountTitle)
            make.top.equalTo(totalAmountIcon.snp.bottom).offset(5)
            make.width.equalTo(totalAmount.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        percentChangeIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(30)
            make.top.equalTo(totalAmount.snp.bottom).offset(15)
            make.width.height.equalTo(22)
        }
        percentChangeTitle.snp.makeConstraints { make in
            make.left.equalTo(percentChangeIcon.snp.right).offset(10)
            make.centerY.equalTo(percentChangeIcon)
            make.width.equalTo(percentChangeTitle.intrinsicContentSize.width)
            make.height.equalTo(16)
        }
        percentChange.snp.makeConstraints { make in
            make.left.equalTo(percentChangeTitle)
            make.top.equalTo(percentChangeIcon.snp.bottom).offset(5)
            make.width.equalTo(percentChange.intrinsicContentSize.width)
            make.height.equalTo(20)
        }
        
        separationLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(averageCostIcon)
            make.width.equalTo(1)
            make.bottom.equalTo(percentChange)
        }
        
        super.updateConstraints()
        
    }
    

}
