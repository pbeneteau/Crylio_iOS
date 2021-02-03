//
//  CryptocurrencyDetailViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 29/01/2021.
//

import UIKit
import SnapKit


class CryptocurrencyDetailViewController: UIViewController, UIScrollViewDelegate {
    
    
    lazy var topBar = CryptoDetailTopBarView()
    lazy var header = UIView()
    lazy var chartView = UIView()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: 414, height: 2000)
        view.backgroundColor = .systemGreen
        view.bounces = true
        return view
    }()
    
    lazy var name = UILabel()
    lazy var symbol = UILabel()
    lazy var type = UILabel()
    
    var crypto: Cryptocurrency? {
        didSet {
            self.topBar.title.text = "Title"
            self.name.text = "Title"
            self.symbol.text = "Text"
            self.type.text = "Type"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        view.addSubview(topBar)
        view.addSubview(header)
        view.addSubview(scrollView)
        
        header.addSubview(name)
        header.addSubview(symbol)
        header.addSubview(type)
        
        scrollView.addSubview(chartView)
        
        topBar.layer.zPosition = 20
        topBar.backgroundColor = .blue
        
        header.backgroundColor = .systemRed
        
        name.textColor = .label
        name.font = .boldSystemFont(ofSize: 34)
        
        symbol.textColor = .label
        type.textColor = .systemGray
        
        
        chartView.backgroundColor = .white
        chartView.isUserInteractionEnabled = true
        
        scrollView.delegate = self
        
        updateViewConstraints()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if header.frame.minY < topBar.frame.maxY - name.frame.minY - name.frame.height/2 {
            topBar.title.alpha = 1
        } else {
            topBar.title.alpha = 0
        }
        
        let y: CGFloat = scrollView.contentOffset.y
        
        print(y)
        
        header.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(90).offset(-y)
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    
    override func updateViewConstraints() {
        
        topBar.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(90)
        }
        
        header.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(90)
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.centerX.bottom.width.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(200)
            make.height.equalTo(41)
        }
        
        symbol.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.left.equalTo(name)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        type.snp.makeConstraints { make in
            make.top.equalTo(symbol)
            make.left.equalTo(symbol.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        chartView.snp.makeConstraints { make in
            make.left.equalTo(scrollView).offset(16)
            make.width.equalTo(scrollView).offset(-32)
            make.top.equalTo(15)
            make.height.equalTo(100)
        }
        
        
        super.updateViewConstraints()
    }
    
    fileprivate func getHeightOfHeaderView() -> CGFloat {
        return header.frame.height
    }
    
}


