//
//  ChartBlockView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import AAInfographics

class ChartView: UIView {
        
    lazy var backgroundBox = RoundedCornersView()

    
    lazy var price = UILabel()
    var priceChangeBox: PriceChangeBoxView!
    lazy var timeframe = UILabel()
    lazy var priceChangeDollar = UILabel()
    lazy var changeChartModeButton = UIButton()
    
    lazy var chartView = AAChartView()
    
//    lazy var timeframeSelector = HorizontalMenu(items: ["1d", "1w", "1m", "3m", "6m", "1y", "All"], scrollable: false)
    lazy var timeframeSelector = UISegmentedControl(items: ["1d", "1w", "1m", "3m", "6m", "1y", "All"])
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(price: Float, changePercent: Float, changeDollar: Float) {
        super.init(frame: CGRect.zero)
        
        self.price.text = "$\(price)"
        self.priceChangeBox = PriceChangeBoxView(change: changePercent)
        self.priceChangeDollar.text = "$\(changeDollar)"
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = .systemGray6
        
        backgroundBox.layer.cornerRadius = 7
        
        price.font = .systemFont(ofSize: 31, weight: .medium)
        
        priceChangeDollar.font = .systemFont(ofSize: 15)
        priceChangeDollar.textColor = .systemGreen
        
        timeframe.font = .systemFont(ofSize: 14)
        timeframe.textColor = .systemGray
        timeframe.text = "Today"
        
        timeframeSelector.selectedSegmentIndex = 0
        
        addSubview(backgroundBox)
                
        backgroundBox.addSubview(price)
        backgroundBox.addSubview(priceChangeDollar)
        backgroundBox.addSubview(priceChangeBox)
        backgroundBox.addSubview(timeframe)
        backgroundBox.addSubview(changeChartModeButton)
        backgroundBox.addSubview(chartView)
        backgroundBox.addSubview(timeframeSelector)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        chartView.scrollEnabled = false
        chartView.isClearBackgroundColor = true
        chartView.delegate = self as AAChartViewDelegate
        
        let arr = [
            1,3,2,5,4,2,3,5,6,5,
            4,6,7,5,6,8,7,5,8,6,
            8,9,6,8,7,8,9,10,11,13,
            9,11,10,13,12,11,10,11,13,11
        ]
                
        let aaChartModel = AAChartModel()
            .chartType(AAChartType.line)
            .colorsTheme(["#5B8FF9"])
            .dataLabelsEnabled(false)
            .animationType(.easeFrom)
            .legendEnabled(false)
            .touchEventEnabled(true)
            .xAxisVisible(false)
            .yAxisVisible(false)
            .markerRadius(0)
            .tooltipEnabled(false)
            .series([
                AASeriesElement()
                    .data(arr)])
        
        chartView.aa_drawChartWithChartModel(aaChartModel)
        
    }
    
    override func updateConstraints() {
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        price.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(37)
        }
        
        priceChangeBox.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(price.snp.bottom).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        priceChangeDollar.snp.makeConstraints { make in
            make.left.equalTo(priceChangeBox.snp.right).offset(10)
            make.centerY.equalTo(priceChangeBox)
            make.height.equalTo(20)
            make.width.equalTo(priceChangeDollar.intrinsicContentSize.width)
        }
        
        timeframe.snp.makeConstraints { make in
            make.left.equalTo(priceChangeDollar.snp.right).offset(10)
            make.centerY.equalTo(priceChangeDollar)
            make.height.equalTo(20)
            make.width.equalTo(timeframe.intrinsicContentSize.width)
        }
        
        changeChartModeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(price)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        chartView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(priceChangeBox.snp.bottom).offset(20)
            make.height.equalTo(200)
        }
        
        timeframeSelector.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


extension ChartView: AAChartViewDelegate {
    
    func aaChartView(_ aaChartView: AAChartView, moveOverEventMessage: AAMoveOverEventMessageModel) {
        guard let price = moveOverEventMessage.y else {return}
        self.price.text = "$\(price)"
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
    }
    
}
