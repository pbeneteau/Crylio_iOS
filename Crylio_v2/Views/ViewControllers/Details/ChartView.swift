//
//  ChartBlockView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import AAInfographics
import WebKit


class ChartView: UIView, WKNavigationDelegate {
        
    lazy var backgroundBox = RoundedCornersView()

    var webView: WKWebView!
    
    
    lazy var chartView = UIView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(price: Float, changePercent: Float, changeDollar: Float) {
        super.init(frame: CGRect.zero)
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        chartView = webView
    }
    
    private func commonInit() {
        
        loadView()
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = .systemGray6
        
        backgroundBox.layer.cornerRadius = 7
                
        addSubview(backgroundBox)
        backgroundBox.addSubview(chartView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //chartView.scrollEnabled = false
        //chartView.isClearBackgroundColor = true
        //chartView.delegate = self as AAChartViewDelegate
        
        backgroundBox.clipsToBounds = true
        webView.loadHTMLString(wchart, baseURL: nil)
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.bounces = false
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
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
        
        //chartView.aa_drawChartWithChartModel(aaChartModel)
        
        print("\n\n\n\n\n\n\n\n\n")
        
    }
    
    override func updateConstraints() {
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        chartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(1.06)
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
        
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
        
    }
    
}
