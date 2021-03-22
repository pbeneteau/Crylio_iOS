//
//  CryptoDetailsScrollView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit


class CryptoDetailScrollView: UIScrollView {
    
    lazy var contentView = UIView()
        
    lazy var chartView = ChartView(price: 41512, changePercent: 7.51, changeDollar: 410)
    
    lazy var marketStatsView = MarketStatsView(volume24: 115149016927.31,
                                               volume24Change: 2.61,
                                               marketCap: 625760348347.31,
                                               marketCapChange: 2.61,
                                               availableSupply: 45425790652.52,
                                               availableSupplyChange: 1.5,
                                               totalSupply: 100000000000.62)
    
    lazy var aboutView = AboutView(name: "Bitcoin", description: "Bitcoin is a decentralized cryptocurrency originally described in a 2008 whitepaper by a person, or group of people, using the alias Satoshi Nakamoto. It was launched soon after, in January 2009.")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        contentInsetAdjustmentBehavior = .never
        
        contentView.backgroundColor = .clear
                
        addSubview(contentView)
        
        contentView.addSubview(chartView)
        contentView.addSubview(marketStatsView)
        contentView.addSubview(aboutView)
    }
    
    @objc func dragingChartView() {
        print("dragging chart")
        isScrollEnabled = false
    }
    
    func updateInsets(menuMaxY: CGFloat) {
        contentInset = UIEdgeInsets(top: menuMaxY, left: 0, bottom: 0, right: 0)
        scrollIndicatorInsets = UIEdgeInsets(top: menuMaxY-20, left: 0, bottom: 0, right: 0)
    }
    
    
    override func updateConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(400 + 382)
        }
        
        chartView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(350)
        }

        marketStatsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(chartView.snp.bottom).offset(30)
            make.height.equalTo(297)
        }
        
        aboutView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(marketStatsView.snp.bottom).offset(30)
            make.width.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        aboutView.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(marketStatsView.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(aboutView.descriptionText.frame.maxY).offset(16)
        }
        
        contentView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(aboutView.frame.maxY)
        }
                
        contentSize = CGSize(width: frame.width, height: contentView.frame.height * 1.4)
    }
    
}
