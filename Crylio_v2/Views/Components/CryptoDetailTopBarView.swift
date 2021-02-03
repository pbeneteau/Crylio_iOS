//
//  CryptoDetailTopBarView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 29/01/2021.
//

import UIKit
import SnapKit


class CryptoDetailTopBarView: UIView {
    
    lazy var title = UILabel()
    lazy var backButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(title)
        addSubview(backButton)
        
        title.textColor = .label
        title.textAlignment = .center
        title.alpha = 0
    }
    
    override func updateConstraints() {
        //set subview constraints here
        
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //manually set subview frames here
    }
    
}
