//
//  CryptoDetailViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit


class CryptoDetailViewController: UIViewController {
    
    lazy var scrollView = CryptoDetailScrollView()
    
    var refreshControl = UIRefreshControl()
    
    var blurredHeaderViewAlpha: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        view.addSubview(scrollView)
        scrollView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        
        print("Refreshing data...")

        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }

}

