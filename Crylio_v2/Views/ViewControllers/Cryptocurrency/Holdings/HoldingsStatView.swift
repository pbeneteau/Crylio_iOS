//
//  HodlingsStatView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 07/05/2021.
//

import UIKit

class HoldingsStatView: RoundedCornersView {
    
    lazy var title = UILabel()
    lazy var value = UILabel()

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        backgroundColor = AppColors.background.secondary
        
        title.font = .systemFont(ofSize: 13)
        value.font = .systemFont(ofSize: 17, weight: .bold)
        
        title.textColor = AppColors.label.secondary
        value.textColor = AppColors.label.primary
        
        addSubview(title)
        addSubview(value)
    }

}


// CONSTRAINTS

extension HoldingsStatView {
    
    override func updateConstraints() {
        
        title.snp.makeConstraints { make in
            make.left.top.equalTo(16)
            make.width.equalToSuperview().offset(32)
            make.height.equalTo(16)
        }
        
        value.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.width.equalToSuperview().offset(32)
            make.height.equalTo(20)
        }
        
        super.updateConstraints()
    }
}
