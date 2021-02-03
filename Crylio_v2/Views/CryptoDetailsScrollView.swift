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
        
        offsetView.backgroundColor = .systemBackground
        
        addSubview(offsetView)
        addSubview(chartView)
        
    }
    
    override func updateConstraints() {
        
        offsetView.snp.makeConstraints { make in
            make.width.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(175+15)
        }
        
        chartView.snp.makeConstraints { make in
            make.width.left.equalToSuperview()
            make.top.equalTo(offsetView.snp.bottom)
            make.height.equalTo(400)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Manually set subview frames here
    }

}
