//
//  CryptoDetailsScrollView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit

class CryptoDetailsScrollView: UIScrollView {
    
    lazy var offsetView = UIView()
    
    lazy var chartView = ChartView(price: 41512, changePercent: 7.51, changeDollar: 410)
    
    lazy var marketStatsView = MarketStatsView(volume24: 115149016927.31,
                                               volume24Change: 2.61,
                                               marketCap: 625760348347.31,
                                               marketCapChange: 2.61,
                                               availableSupply: 45425790652.52,
                                               availableSupplyChange: 1.5,
                                               totalSupply: 100000000000.62)
    
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
        backgroundColor = .systemBackground
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
        
        offsetView.backgroundColor = .systemBackground
        
        addSubview(offsetView)
        addSubview(chartView)
        addSubview(marketStatsView)
        
    }
    
    override func updateConstraints() {
        
        offsetView.snp.makeConstraints { make in
            make.width.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(175+15)
        }
        
        chartView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(offsetView.snp.bottom)
            make.height.equalTo(400)
        }

        marketStatsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(chartView.snp.bottom).offset(30)
            make.height.equalTo(204)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        marketStatsView.setNeedsLayout()
        
        // Manually set subview frames here
    }

}
