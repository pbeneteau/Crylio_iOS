//
//  PriceChangeBoxView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import UIKit
import SnapKit


class PriceChangeBox: UIView {
    
    lazy var box = UIImageView()
    lazy var change = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    
    init(change: Float) {
        super.init(frame: CGRect.zero)
        
        box.image = UIImage(named: "priceUp")
        self.change.textColor = .systemGreen
        
        if change < 0 {
            box.image = UIImage(named: "priceDown")
            self.change.textColor = .systemRed
        }
        
        self.change.text = percentFormat(change)
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        
        change.textAlignment = .right
        change.font = .systemFont(ofSize: 17)
        
        addSubview(box)
        addSubview(change)
    }
    
    override func updateConstraints() {
        
        box.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(self.snp.height)
        }
        
        change.snp.makeConstraints { make in
            make.left.equalTo(box.snp.right).offset(5)
            make.top.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(change.intrinsicContentSize.width)
        }
        
        super.updateConstraints()
    }
    
    
}
