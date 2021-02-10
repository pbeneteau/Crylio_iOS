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
    lazy var icon = UIImageView()
    
    lazy var addButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(name: String, symbol: String, type: String, icon: UIImage) {
        super.init(frame: CGRect.zero)
        
        self.nameLabel.text = name
        self.symbolLabel.text = symbol
        self.typeLabel.text = type
        self.icon.image = icon
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        nameLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        symbolLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        typeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        nameLabel.textColor = .label
        symbolLabel.textColor = .label
        typeLabel.textColor = .systemGray
        

        
        // create add image
        let config = UIImage.SymbolConfiguration(pointSize: 25.0, weight: .medium, scale: .medium)
        let addImage = UIImage(systemName: "add", withConfiguration: config)
        let removeImage = UIImage(systemName: "stop", withConfiguration: config)
        
        addButton.titleLabel?.font = .systemFont(ofSize: 15)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitle("Remove", for: .selected)
        addButton.setImage(addImage, for: .normal)
        addButton.setImage(removeImage, for: .selected)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitle("Remove", for: .selected)
        addButton.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: .touchUpInside)
        
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(typeLabel)
        addSubview(icon)
        addSubview(addButton)
    }
    
    @objc func addButtonAction(sender: UIButton!) {
        
    }
    
    override func updateConstraints() {
        
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(34)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(addButton.snp.top).offset(-10)
            make.height.equalTo(17)
            make.width.equalTo(symbolLabel.intrinsicContentSize)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel.snp.right).offset(15)
            make.bottom.equalTo(symbolLabel)
            make.height.equalTo(17)
            make.width.equalTo(typeLabel.intrinsicContentSize)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(symbolLabel.snp.top).offset(-5)
            make.height.equalTo(41)
            make.width.equalTo(nameLabel.intrinsicContentSize)
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.centerY)
            make.height.width.equalTo(38)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addButton.backgroundColor = .clear
        addButton.layer.cornerRadius = 7
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

}
