//
//  AboutView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit

class AboutView: UIView {
    
    lazy var title = UILabel()
    lazy var backgroundBox = RoundedCornersView()
    
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
        
        backgroundBox.layer.cornerRadius = 10
        backgroundBox.backgroundColor = .systemGray6
        
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = .label
        
        descriptionText.font = .systemFont(ofSize: 17)
        descriptionText.textColor = .systemGray
        descriptionText.numberOfLines = 0
        
        descriptionText.sizeToFit()
        
        addSubview(title)
        addSubview(backgroundBox)
        
        backgroundBox.addSubview(descriptionText)
        
        backgroundBox.translatesAutoresizingMaskIntoConstraints = false
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
            make.bottom.equalToSuperview()
            make.width.height.equalToSuperview().offset(-32)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionText.sizeToFit()
    }

}
