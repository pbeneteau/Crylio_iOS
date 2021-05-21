//
//  ChartViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 11/05/2021.
//

import UIKit
import WebKit


class ChartViewController: BaseViewController, WKNavigationDelegate, UIScrollViewDelegate {
    
    lazy var webView = WKWebView()
        
    var tradingViewChart: TradingViewChart!


    override func viewDidLoad() {
        super.viewDidLoad()
                
        initChartView()
 
        reloadChart()
    }
    
    
    func initChartView() {
        
        webView.navigationDelegate = self
        
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.isScrollEnabled = false
        //webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.bounces = false
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(webView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func reloadChart() {
        
        webView.loadHTMLString(tradingViewChart.getFullChart(), baseURL: nil)
    }
}


// CONSTRAINTS

extension ChartViewController {
    
    override func updateViewConstraints() {
        
        webView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
}


// DARK MODE HANDLING

extension ChartViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        tradingViewChart.theme = traitCollection.userInterfaceStyle == .dark ? .dark: .light
        reloadChart()
    }
}
