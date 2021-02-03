//
//  PriceChangeBoxView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit


class PriceChangeBoxView: RoundedCornersView {
        
    lazy var change = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    
    init(change: Float) {
        super.init(frame: CGRect.zero)
        
        self.change.text = "\(change) %"
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        layer.cornerRadius = 10
        
        addSubview(change)
        
        backgroundColor = UIColor.systemGreen
        
        change.textColor = UIColor.white
        change.textAlignment = .center
        change.font = UIFont.systemFont(ofSize: 15)
    }
    
    override func updateConstraints() {
        
        change.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //manually set subview frames here
    }
    
}
