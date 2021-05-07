//
//  CryptoDetailViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit


class CryptoDetailViewController: BaseViewController {
    
    var blurredHeaderViewAlpha: CGFloat = 0.0
    
    var scrollView: CryptoDetailScrollView!
    weak var scrollViewDelegate: ScrollViewDidScrollDelegate?

    var refreshControl = UIRefreshControl()
    
    var crypto: Cryptocurrency!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = CryptoDetailScrollView(crypto: crypto)
        
        scrollView.delegate = self
        
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

}


// SCROLL VIEW DELEGATE

extension CryptoDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        guard let delegate = scrollViewDelegate else { return }
        delegate.scrollViewDidScrollVertically(scrollView: scrollView)
    }
    
}


// CONSTRAINTS

extension CryptoDetailViewController {
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
}


// DARK MODE HANDLING

extension CryptoDetailViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        scrollView.chartView.updateChart()
    }
}
