//
//  CryptoHoldingsScrollView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit
import SnapKit


class CryptoHoldingsScrollView: UIScrollView {

    lazy var contentView = UIView()
        
    lazy var holdingsStatsView = HoldingsStatsView(worth: 123415.42, averageCost: 6421.74, totalAmount: 3.1, profitLoss: 120415.06, percentChange: 1401.85)
    
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
        
        contentView.addSubview(holdingsStatsView)
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
        
        holdingsStatsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(227)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentSize = CGSize(width: frame.width, height: contentView.frame.height * 1.4)
                
    }

}
