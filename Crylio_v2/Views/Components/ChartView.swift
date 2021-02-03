//
//  ChartBlockView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit

class ChartView: UIView {
    
    
    lazy var backgroundBox = RoundedCornersView()
    
    lazy var priceLabel = UILabel()
    var priceChangeBox: PriceChangeBoxView!
    lazy var priceChangeDollar = UILabel()
    lazy var changeChartModeButton = UIButton()
    
    lazy var timeframeSelector = HorizontalMenu(items: ["1d", "1w", "1m", "3m", "6m", "1y", "All"])

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(price: Float, changePercent: Float, changeDollar: Float) {
        super.init(frame: CGRect.zero)
        
        priceLabel.text = "$\(price)"
        priceChangeBox = PriceChangeBoxView(change: changePercent)
        priceChangeDollar.text = "$\(changeDollar)"
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        
        backgroundBox.layer.cornerRadius = 10
        backgroundBox.backgroundColor = .systemGray6
        
        priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        priceChangeDollar.font = UIFont.systemFont(ofSize: 15)
        priceChangeDollar.textColor = .systemGreen
        
        timeframeSelector.backgroundColor = .systemGray5
        timeframeSelector.selectedButtonView.backgroundColor = .systemGray4
        
        addSubview(backgroundBox)
        backgroundBox.addSubview(priceLabel)
        backgroundBox.addSubview(priceChangeDollar)
        backgroundBox.addSubview(priceChangeBox)
        backgroundBox.addSubview(changeChartModeButton)
        backgroundBox.addSubview(timeframeSelector)
    }
    
    override func updateConstraints() {
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.width.equalTo(200)
        }
        
        priceChangeBox.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(priceLabel.snp.bottom).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        priceChangeDollar.snp.makeConstraints { make in
            make.left.equalTo(priceChangeBox.snp.right).offset(10)
            make.centerY.equalTo(priceChangeBox)
            make.height.equalTo(30)
            make.width.equalTo(150)
        }
        
        changeChartModeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(priceLabel)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        timeframeSelector.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //manually set subview frames here
    }
}
