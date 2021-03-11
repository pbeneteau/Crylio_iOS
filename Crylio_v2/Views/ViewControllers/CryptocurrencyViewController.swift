//
//  Test2ViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit
import SnapKit
import PagingKit


class CryptocurrencyViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var navigationTopBar = NavigationTopBarView()
    var header = CryptoDetailHeaderView(name: "Bitcoin", symbol: "BTC", type: "Coin", icon: UIImage(named: "btc")!)
    var menu = HorizontalMenu(items: ["Details", "Holding", "Orders", "Transactions"], scrollable: true)
    
    lazy var menuScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.tag = 0
        view.backgroundColor = .clear
        view.bounces = false
        view.contentSize = CGSize(width: 1, height: 1)
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()
    
    // MARK: ViewControllers
    lazy var detailVC = CryptoDetailViewController()
    lazy var holdingsVC = CryptoHoldingsViewController()
    lazy var ordersVC = CryptoOrdersViewController()
    lazy var historyVC = CryptoHistoryViewController()
    
    var viewDidLayoutFirstTime = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addChild(detailVC)
        detailVC.didMove(toParent: self)
        
        addChild(holdingsVC)
        holdingsVC.didMove(toParent: self)
        
        addChild(ordersVC)
        ordersVC.didMove(toParent: self)
        
        addChild(historyVC)
        historyVC.didMove(toParent: self)
        
        
        navigationTopBar.title.text = "Bitcoin"
        
        menu.delegate = self
                
        view.addSubview(menuScrollView)
        menuScrollView.addSubview(detailVC.view)
        menuScrollView.addSubview(holdingsVC.view)
        menuScrollView.addSubview(ordersVC.view)
        menuScrollView.addSubview(historyVC.view)
        
        view.addSubview(header)
        view.addSubview(navigationTopBar)
        view.addSubview(menu)
        
        view.setNeedsUpdateConstraints()
        
        menuScrollView.contentSize.width = view.frame.size.width * 4
        menuScrollView.contentSize.height = 1
                
        detailVC.scrollView.tag = 1
        detailVC.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension CryptocurrencyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.tag == 1 {
            
            let yOffset = scrollView.contentOffset.y + scrollView.contentInset.top
            
                        
            header.transform = CGAffineTransform(translationX: 0, y: min(0, -yOffset))
            
            menu.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.width.equalToSuperview().offset(-16)
                make.height.equalTo(40)
                make.top.equalTo(max(navigationTopBar.topBar.frame.maxY, header.frame.maxY))
            }
                        
            navigationTopBar.blurredView.alpha = min(1, 2 - header.frame.maxY/menu.frame.minY*2)
            
            if max(navigationTopBar.topBar.frame.maxY, header.frame.maxY) == navigationTopBar.topBar.frame.maxY {
                navigationTopBar.topBar.alpha = 0
                header.alpha = 0
                
            } else {
                navigationTopBar.blurredView.alpha = 0
                navigationTopBar.topBar.alpha = 1
                header.alpha = 1
            }
            
            if header.nameLabel.frame.maxY/1.5 + header.frame.minY < navigationTopBar.topBar.frame.maxY {
                navigationTopBar.showTitle()
            } else {
                navigationTopBar.hideTitle()
            }
        } else {
            
            let xOffset = scrollView.contentOffset.x
            
            switch xOffset {
            case 0...view.frame.width/2-1:
                menu.setSelectedButton(tag: 0)
            case view.frame.width/2...view.frame.width*1.5-1:
                menu.setSelectedButton(tag: 1)
            case view.frame.width*1.5...view.frame.width*2.5-1:
                menu.setSelectedButton(tag: 2)
            case view.frame.width*2.5...view.frame.width*3:
                menu.setSelectedButton(tag: 3)
            default:
                menu.setSelectedButton(tag: 0)
            }
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if scrollView.tag == 1 {
//
//            if header.symbolLabel.frame.maxY + header.frame.minY >= navigationTopBar.topBar.frame.maxY {
//                scrollView.setContentOffset(CGPoint(x: 0, y: 0 - scrollView.contentInset.top), animated: true)
//            } else if header.symbolLabel.frame.maxY + header.frame.minY < navigationTopBar.topBar.frame.maxY
//                        && menu.frame.minY != navigationTopBar.topBar.frame.maxY {
//                scrollView.setContentOffset(CGPoint(x: 0, y: 129.33333333 - scrollView.contentInset.top), animated: true)
//            }
//        } else if scrollView.tag == 0 {
//
//        }
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.tag == 1 {
//
//            if header.symbolLabel.frame.maxY + header.frame.minY >= navigationTopBar.topBar.frame.maxY {
//                scrollView.setContentOffset(CGPoint(x: 0, y: 0 - scrollView.contentInset.top), animated: true)
//            } else if header.symbolLabel.frame.maxY + header.frame.minY < navigationTopBar.topBar.frame.maxY
//                        && menu.frame.minY != navigationTopBar.topBar.frame.maxY {
//                scrollView.setContentOffset(CGPoint(x: 0, y: 129.33333333 - scrollView.contentInset.top), animated: true)
//            }
//        }
//    }
}


extension CryptocurrencyViewController: HorizontalMenuProtocol, BackButtonProtocol {
    
    func menuButtonTapped(sender: UIButton!) {
        
        print("Menu button \(sender.tag) tapped")
        
        //menuScrollView.setContentOffset(CGPoint(x: Int(view.bounds.width) * sender.tag, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .curveEaseOut]) {
            self.menuScrollView.contentOffset = CGPoint(x: Int(self.view.bounds.width) * sender.tag, y: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    func backButtonAction(sender: UIButton!) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension CryptocurrencyViewController {
    
    override func updateViewConstraints() {
        
        navigationTopBar.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(91 + 35 + 8)
        }
        
        header.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(navigationTopBar.topBar.snp.bottom)
            make.height.equalTo(130)
        }
        
        menu.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.top.equalTo(header.snp.bottom)
        }
        
        menuScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        detailVC.view.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
        
        holdingsVC.view.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(detailVC.view.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
        
        ordersVC.view.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(holdingsVC.view.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
        
        historyVC.view.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(ordersVC.view.snp.right)
            make.bottom.equalTo(view)
            make.top.equalToSuperview()
            make.width.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if viewDidLayoutFirstTime {
            
            viewDidLayoutFirstTime = false
            
            detailVC.scrollView.updateInsets(menuMaxY: menu.frame.maxY)
            holdingsVC.scrollView.updateInsets(menuMaxY: menu.frame.maxY)
        }
    }
    
}
