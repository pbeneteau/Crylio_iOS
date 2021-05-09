//
//  ChartBlockView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import WebKit


class ChartView: UIView {
        
    lazy var backgroundBox = RoundedCornersView()

    var webView: WKWebView!
    
    lazy var chartView = UIView()
    

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
        
        loadView()
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = AppColors.background.secondary
        
        backgroundBox.layer.cornerRadius = 10
        
        backgroundBox.clipsToBounds = true
        
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.bounces = false
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        addSubview(backgroundBox)
        backgroundBox.addSubview(chartView)
        
        updateChart()
    }
    
    func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        chartView = webView
    }
    
    func updateChart() {
        
        webView.loadHTMLString(TradingViewChart.getChart(exchange: "BINANCE", symbol: "VETUSDT", interval: "D", theme: traitCollection.userInterfaceStyle == .dark ? "dark": "light"), baseURL: nil)
    }
    
    override func updateConstraints() {
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview()
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

	
extension ChartView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                
        guard case .linkActivated = navigationAction.navigationType,
              let url = navigationAction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        UIApplication.shared.open(url)
        
   }
    
    
}
