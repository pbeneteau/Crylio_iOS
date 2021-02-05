//
//  Test2ViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit
import SnapKit


class Test2ViewController: UIViewController, UIScrollViewDelegate {
    
    var navigationTopBar = NavigationTopBarView()
    var header = CryptoDetailHeaderView(name: "Bitcoin", symbol: "BTC", type: "Coin")
    var menu = HorizontalMenu(items: ["Details", "Holding", "Orders", "Transactions", "Transactions", "Transactions"], scrollable: true)
    
    lazy var scrollView: CryptoDetailsScrollView = {
        let view = CryptoDetailsScrollView()
        view.contentSize = CGSize(width: 428, height: 2000)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = true
        
        navigationTopBar.title.text = "Bitcoin"
        
        menu.delegate = self
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        view.addSubview(header)
        view.addSubview(navigationTopBar)
        view.addSubview(menu)
        
//        view.backgroundColor = .cyan
//        scrollView.backgroundColor = .blue
//        header.backgroundColor = .green
//        menu.backgroundColor = .red
//        navigationTopBar.backgroundColor = .brown
//        navigationTopBar.topBar.backgroundColor = .systemPink
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        navigationTopBar.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(91 + 35 + 8)
        }
        
        header.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(155)
        }
                
        menu.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(35)
            make.top.equalTo(header.snp.bottom)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        header.transform = CGAffineTransform(translationX: 0, y: max(-header.bounds.height, header.bounds.minY - yOffset))
        
        menu.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(35)
            make.top.equalTo(max(navigationTopBar.topBar.frame.maxY, header.frame.maxY))
        }
                        
        navigationTopBar.blurredView.alpha = 1 - header.frame.maxY/navigationTopBar.topBar.frame.maxY

        if max(navigationTopBar.topBar.frame.maxY, header.frame.maxY) == navigationTopBar.topBar.frame.maxY {
            navigationTopBar.topBar.alpha = 0
            header.alpha = 0
            
        } else {
            navigationTopBar.blurredView.alpha = 0
            navigationTopBar.topBar.alpha = 1
            header.alpha = 1
        }
        
        if header.frame.minY <= navigationTopBar.title.frame.maxY - header.nameLabel.frame.minY - header.nameLabel.frame.height/2 {
            navigationTopBar.showTitle()
        } else {
            navigationTopBar.hideTitle()
        }
    }
    
}


extension Test2ViewController: HorizontalMenuProtocol, BackButtonProtocol {
    func menuButtonTapped(sender: UIButton!) {
        print("button \(sender.tag) tapped")
    }
    
    func backButtonAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}
