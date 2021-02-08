//
//  CryptoHoldingsScrollView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit
import SnapKit


class CryptoHoldingsScrollView: UIScrollView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        showsVerticalScrollIndicator = false
        
        
        contentSize = CGSize(width: 428, height: 2000)
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentInsetAdjustmentBehavior = .never   
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        // Manually set subview frames here
    }

}
