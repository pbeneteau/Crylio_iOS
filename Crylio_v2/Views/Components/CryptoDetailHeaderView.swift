//
//  CryptoDetailHeaderView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit

class CryptoDetailHeaderView: UIView {
    
    lazy var nameLabel = UILabel()
    lazy var symbolLabel = UILabel()
    lazy var typeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(name: String, symbol: String, type: String) {
        super.init(frame: CGRect.zero)
        
        self.nameLabel.text = name
        self.symbolLabel.text = symbol
        self.typeLabel.text = type
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        symbolLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        nameLabel.textColor = .label
        symbolLabel.textColor = .label
        typeLabel.textColor = .systemGray
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(typeLabel)
    }
    
    override func updateConstraints() {
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel.snp.right).offset(15)
            make.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(symbolLabel.snp.top).offset(-10)
            make.height.equalTo(41)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //manually set subview frames here
    }

}
