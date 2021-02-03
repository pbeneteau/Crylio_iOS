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
    var menu = HorizontalMenu(items: ["Details", "Holding", "History"])
    
    lazy var scrollView: CryptoDetailsScrollView = {
                let view = CryptoDetailsScrollView()
                view.contentSize = CGSize(width: 414, height: 2000)
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
                
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationTopBar.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(145)
        }
        
        header.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(155)
        }
        
        menu.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(header.snp.bottom).offset(15)
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        print(y)

        if y >= 0.0 {
            
            header.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(-y)
            }
            
            if header.frame.maxY <= navigationTopBar.topBar.frame.maxY - 8 {
                
                let alphaOffset = abs(header.frame.maxY - navigationTopBar.topBar.frame.maxY)/100
                
                navigationTopBar.blurredView.alpha = alphaOffset*2
                navigationTopBar.topBar.alpha = 0
                header.alpha = 0
                
                menu.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview()
                    make.height.equalTo(40)
                    make.bottom.equalTo(navigationTopBar).offset(-8)
                    
                }
            } else {
                menu.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview()
                    make.height.equalTo(40)
                    make.top.equalTo(header.snp.bottom).offset(15)
                }
                navigationTopBar.topBar.alpha = 1
                header.alpha = 1
            }
        } else {
            header.snp.updateConstraints { make in
                make.top.equalToSuperview()
            }
            
            menu.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview()
                make.height.equalTo(40)
                make.top.equalTo(header.snp.bottom).offset(15)
            }
        }
        
        if header.frame.minY <= navigationTopBar.title.frame.maxY - header.nameLabel.frame.minY - header.nameLabel.frame.height/2 {
            navigationTopBar.showTitle()
        } else {
            navigationTopBar.hideTitle()
        }
    }
}


extension Test2ViewController: HorizontalMenuProtocol {
    func menuButtonTapped(sender: UIButton!) {
        print("button \(sender.tag) tapped")
    }
}
