//
//  PriceChangeBoxView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit


class PriceChangeBoxView: UIView {
    
    lazy var box = RoundedCornersView()
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
        
        
        addSubview(box)
        addSubview(change)
        
        backgroundColor = .clear
        
        box.layer.cornerRadius = 10
        box.backgroundColor = .systemGreen
        box.alpha = 0.07
        
        change.textColor = .systemGreen
        change.textAlignment = .center
        change.font = .systemFont(ofSize: 15)
    }
    
    override func updateConstraints() {
        
        box.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
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
