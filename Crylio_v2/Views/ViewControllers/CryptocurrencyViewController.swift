//
//  Test2ViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 30/01/2021.
//

import UIKit
import SnapKit
import PagingKit


class CryptocurrencyViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate {
    
    var navigationTopBar = NavigationTopBarView()
    var header = CryptoDetailHeaderView(name: "Bitcoin", symbol: "BTC", type: "Coin", icon: UIImage(named: "btc")!)
    var menu = HorizontalMenu(items: ["Details", "Holding", "Orders", "Transactions"], scrollable: true)
    
    lazy var menuScrollView: UIScrollView = {
        
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.tag = 10
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
    lazy var transactionsVC = CryptoTransactionsViewController()
    
    var viewDidLayoutFirstTime = true
    
    var displayedVCTag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addChild(detailVC)
        detailVC.didMove(toParent: self)
        
        addChild(holdingsVC)
        holdingsVC.didMove(toParent: self)
        
        addChild(ordersVC)
        ordersVC.didMove(toParent: self)
        
        addChild(transactionsVC)
        transactionsVC.didMove(toParent: self)
        
        
        navigationTopBar.title.text = "Bitcoin"
        
        menu.delegate = self
                
        view.addSubview(menuScrollView)
        menuScrollView.addSubview(detailVC.view)
        menuScrollView.addSubview(holdingsVC.view)
        menuScrollView.addSubview(ordersVC.view)
        menuScrollView.addSubview(transactionsVC.view)
        
        view.addSubview(header)
        view.addSubview(navigationTopBar)
        view.addSubview(menu)
        
        view.setNeedsUpdateConstraints()
        
        menuScrollView.contentSize.width = view.frame.size.width * 4
        menuScrollView.contentSize.height = 1
                
        detailVC.scrollView.tag = 0
        detailVC.scrollView.delegate = self
        
        holdingsVC.scrollView.tag = 1
        holdingsVC.scrollView.delegate = self
        
        ordersVC.tableView.tag = 2
        ordersVC.tableView.delegate = self
        
        transactionsVC.tableView.tag = 3
//        transactionsVC.tableView.delegate = self
        
        detailVC.view.tag = 0
        holdingsVC.view.tag = 1
        ordersVC.view.tag = 2
        transactionsVC.view.tag = 3
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension CryptocurrencyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y + scrollView.contentInset.top
        
        if scrollView.tag == displayedVCTag {
                                    
            updateHeader(yOffset: yOffset)
                        
        } else if scrollView.tag == 10 {
            
            let xOffset = scrollView.contentOffset.x
            
            switch xOffset {
            case 0...view.frame.width/2-1:
                displayedVCTag = 0
                menu.setSelectedButton(index: displayedVCTag)
                updateHeaderAlpha()
            case view.frame.width/2...view.frame.width*1.5-1:
                displayedVCTag = 1
                menu.setSelectedButton(index: displayedVCTag)
                updateHeaderAlpha()
            case view.frame.width*1.5...view.frame.width*2.5-1:
                displayedVCTag = 2
                menu.setSelectedButton(index: displayedVCTag)
                updateHeaderAlpha()
            case view.frame.width*2.5...view.frame.width*3:
                displayedVCTag = 3
                menu.setSelectedButton(index: displayedVCTag)
                updateHeaderAlpha()
            default:
                return
            }
        }
    }
    
    func updateHeader(yOffset: CGFloat) {
                        
        header.transform = CGAffineTransform(translationX: 0, y: min(0, -yOffset))
        
        menu.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.top.equalTo(max(navigationTopBar.topBar.frame.maxY, header.frame.maxY))
        }
                    
        navigationTopBar.blurredView.alpha = min(1, 2 - header.frame.maxY/menu.frame.minY*2)
        
        saveBlurredViewAlpha(alpha: navigationTopBar.blurredView.alpha)
        
        if max(navigationTopBar.topBar.frame.maxY, header.frame.maxY) == navigationTopBar.topBar.frame.maxY {
            
            navigationTopBar.topBar.alpha = 0
            header.alpha = 0
            
        } else {
            navigationTopBar.blurredView.alpha = 0
            saveBlurredViewAlpha(alpha: 0)
            
            navigationTopBar.topBar.alpha = 1
            header.alpha = 1
        }
        
        if header.nameLabel.frame.maxY/1.5 + header.frame.minY < navigationTopBar.topBar.frame.maxY {
            navigationTopBar.showTitle()
        } else {
            navigationTopBar.hideTitle()
        }
    }
    
    func saveBlurredViewAlpha(alpha: CGFloat) {
        
        switch displayedVCTag {
        case 0:
            detailVC.blurredHeaderViewAlpha = alpha
        case 1:
            holdingsVC.blurredHeaderViewAlpha = alpha
        case 2:
            ordersVC.blurredHeaderViewAlpha = alpha
        case 3:
            transactionsVC.blurredHeaderViewAlpha = alpha
        default:
            return
        }
    }
    
    func updateHeaderAlpha() {
        
        switch displayedVCTag {
        case 0:
            navigationTopBar.blurredView.alpha = detailVC.blurredHeaderViewAlpha
        case 1:
            navigationTopBar.blurredView.alpha = holdingsVC.blurredHeaderViewAlpha
        case 2:
            navigationTopBar.blurredView.alpha = ordersVC.blurredHeaderViewAlpha
        case 3:
            navigationTopBar.blurredView.alpha = transactionsVC.blurredHeaderViewAlpha
        default:
            return
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.tag != 10 {
            
            updateOffset(scrollView: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.tag != 10 {
            
            updateOffset(scrollView: scrollView)
        }
    }
    
    
    func updateOffset(scrollView: UIScrollView) {
        
        let scrollViewOffsetBigHeader = -scrollView.contentInset.top
        let scrollViewOffsetSmallHeader = 129.33333333333334 - scrollView.contentInset.top
                
        if header.symbolLabel.frame.maxY + header.frame.minY >= navigationTopBar.topBar.frame.maxY {
                        
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewOffsetBigHeader), animated: true)

            setNewOffset(newOffset: scrollViewOffsetBigHeader)
        
        } else if header.symbolLabel.frame.maxY + header.frame.minY < navigationTopBar.topBar.frame.maxY
                    && menu.frame.minY != navigationTopBar.topBar.frame.maxY {
                        
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewOffsetSmallHeader), animated: true)
            
            setNewOffset(newOffset: scrollViewOffsetSmallHeader)
            
        } else {
            
            if scrollView.tag == 0 {
                if holdingsVC.scrollView.contentOffset.y < scrollViewOffsetSmallHeader {
                    
                    holdingsVC.scrollView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                    transactionsVC.tableView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                }
            } else if scrollView.tag == 1 {
                if detailVC.scrollView.contentOffset.y < scrollViewOffsetSmallHeader {
                    
                    detailVC.scrollView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                    transactionsVC.tableView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                }
            } else if scrollView.tag == 2 {
                if ordersVC.tableView.contentOffset.y < scrollViewOffsetSmallHeader {
                    
                    detailVC.scrollView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                    transactionsVC.tableView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                }
            } else if scrollView.tag == 3 {
                if transactionsVC.tableView.contentOffset.y < scrollViewOffsetSmallHeader {
                    
                    detailVC.scrollView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                    holdingsVC.scrollView.contentOffset = CGPoint(x: 0, y: scrollViewOffsetSmallHeader)
                }
            }
        }
    }
    
    func setNewOffset(newOffset: CGFloat) {
        
        if displayedVCTag != 0 {
            detailVC.scrollView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
        if displayedVCTag != 1 {
            holdingsVC.scrollView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
        if displayedVCTag != 2 {
            ordersVC.tableView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
        if displayedVCTag != 3 {
            transactionsVC.tableView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
    }
    
}


extension CryptocurrencyViewController: HorizontalMenuProtocol, BackButtonProtocol {
    
    func menuButtonTapped(sender: UIButton!) {
                
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
        
        transactionsVC.view.snp.makeConstraints { (make) -> Void in
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
            ordersVC.updateInsets(menuMaxY: menu.frame.maxY)
            transactionsVC.updateInsets(menuMaxY: menu.frame.maxY)
        }
    }
    
}
