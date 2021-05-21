//
//  ChartBlockView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit
import WebKit


protocol ChartViewDelegate: AnyObject {
    
    func chartViewDoubleTapped()
}


class ChartView: UIView, UIGestureRecognizerDelegate {
        
    lazy var backgroundBox = RoundedCornersView()

    lazy var chartView = WKWebView()
        
    weak var delegate: ChartViewDelegate!


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
                
        backgroundColor = .clear
        
        backgroundBox.backgroundColor = AppColors.background.secondary
        backgroundBox.layer.cornerRadius = 10
        backgroundBox.clipsToBounds = true
        
        chartView.allowsBackForwardNavigationGestures = false
        chartView.scrollView.isScrollEnabled = false
        chartView.scrollView.showsVerticalScrollIndicator = false
        chartView.backgroundColor = .clear
        chartView.scrollView.bounces = false
        chartView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        chartView.scrollView.contentInsetAdjustmentBehavior = .never
        chartView.navigationDelegate = self

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chartViewDoubleTapped))
        tap.delegate = self
        tap.numberOfTapsRequired = 2
        
        chartView.addGestureRecognizer(tap)
        
        addSubview(backgroundBox)
        backgroundBox.addSubview(chartView)
        
        updateChart()
    }
    
    func updateChart() {
        
        let t = TradingViewChart(symbol: "BTCUSDT", exchange: .binance, theme: .dark, interval: .day)
        
        chartView.loadHTMLString(t.getMinimizedChart(), baseURL: nil)
    }
    
    @objc func chartViewDoubleTapped() {
        
        delegate.chartViewDoubleTapped()
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

extension ChartView {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
}
