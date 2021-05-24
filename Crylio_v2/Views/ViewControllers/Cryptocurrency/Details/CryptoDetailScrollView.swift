//
//  CryptoDetailsScrollView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit


class CryptoDetailScrollView: UIScrollView {
    
    lazy var contentView = UIView()
    lazy var chartView = ChartView()
    lazy var marketStatsView = MarketStatsView()
    lazy var aboutView = AboutView()
    lazy var balanceView = CryptoDetailBalanceView()
    
    var crypto: Cryptocurrency! {
        didSet {
            initValues()
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
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        contentInsetAdjustmentBehavior = .never
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
                
        addSubview(contentView)
        
        contentView.addSubview(chartView)
        contentView.addSubview(balanceView)
        contentView.addSubview(marketStatsView)
        contentView.addSubview(aboutView)
    }
    
    private func initValues() {
        
        marketStatsView.marketStats = crypto.marketStats
        
        aboutView.name = crypto.name
        aboutView.descriptionString = crypto.description
        
        balanceView.iconView.setImage(from: crypto.iconURL)
        balanceView.symbol = crypto.symbol
        balanceView.worth = Float(13415.42)
        balanceView.amount = Float(3.1)
    }
    
    
    func updateInsets(menuMaxY: CGFloat) {
        
        contentInset = UIEdgeInsets(top: menuMaxY, left: 0, bottom: 0, right: 0)
        scrollIndicatorInsets = UIEdgeInsets(top: menuMaxY-20, left: 0, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        aboutView.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(marketStatsView.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(aboutView.descriptionTextLabel.frame.maxY).offset(16)
        }
        
        contentView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(aboutView.frame.maxY)
        }
                
        contentSize = CGSize(width: frame.width, height: contentView.frame.height * 1.4)
    }
    
}


// CONSTRAINTS

extension CryptoDetailScrollView {
    
    override func updateConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(400 + 382)
        }
        
        chartView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(350)
        }
        
        balanceView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(chartView.snp.bottom).offset(30)
            make.height.equalTo(74)
        }

        marketStatsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(balanceView.snp.bottom).offset(30)
            make.height.equalTo(297)
        }
        
        aboutView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(marketStatsView.snp.bottom).offset(30)
            make.width.equalToSuperview()
        }
        
        super.updateConstraints()
    }
}
