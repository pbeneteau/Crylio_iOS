//
//  CryptoDetailViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit

class CryptoDetailViewController: UIViewController {
    
    lazy var scrollView = CryptoDetailScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
    }
    
    override func updateViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }

}
