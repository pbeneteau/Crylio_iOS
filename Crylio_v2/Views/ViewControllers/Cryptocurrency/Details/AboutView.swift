//
//  AboutView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit

class AboutView: UIView {
    
    lazy var title = UILabel()
    
    lazy var backgroundBox = UIView()
    
    lazy var descriptionText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(name: String, description: String) {
        super.init(frame: CGRect.zero)
        
        self.title.text = "About \(name)"
        self.descriptionText.text = description
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        backgroundBox.backgroundColor = AppColors.background.secondary
        
        backgroundBox.layer.cornerRadius = 7
        
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = .label
        
        descriptionText.font = .systemFont(ofSize: 17)
        descriptionText.textColor = .systemGray
        descriptionText.numberOfLines = 0
        
        descriptionText.sizeToFit()
        
        addSubview(title)
        
        addSubview(backgroundBox)
        
        backgroundBox.addSubview(descriptionText)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateConstraints() {
        
        title.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.left.equalTo(16)
            make.top.equalToSuperview()
            make.height.equalTo(22)
        }
        
        backgroundBox.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalTo(descriptionText.snp.bottom).offset(16)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionText.sizeToFit()
        
    }

}
