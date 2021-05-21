//
//  AboutView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 08/02/2021.
//

import UIKit

class AboutView: UIView {
    
    lazy var titleLabel = UILabel()
    lazy var backgroundBoxView = UIView()
    lazy var descriptionTextLabel = UILabel()
    
    var descriptionString: String! {
        didSet {
            descriptionTextLabel.text = descriptionString!
        }
    }
    
    var name: String! {
        didSet {
            titleLabel.text = "About \(name!)"
        }
    }

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
        
        backgroundColor = .clear
        backgroundBoxView.backgroundColor = AppColors.background.secondary
        
        backgroundBoxView.layer.cornerRadius = 7
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        
        descriptionTextLabel.font = .systemFont(ofSize: 17)
        descriptionTextLabel.textColor = .systemGray
        descriptionTextLabel.numberOfLines = 0
        descriptionTextLabel.sizeToFit()
        
        addSubview(titleLabel)
        addSubview(backgroundBoxView)
        backgroundBoxView.addSubview(descriptionTextLabel)
    }
    
    override func updateConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.left.equalTo(16)
            make.top.equalToSuperview()
            make.height.equalTo(22)
        }
        
        backgroundBoxView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalTo(descriptionTextLabel.snp.bottom).offset(16)
        }
        
        descriptionTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionTextLabel.sizeToFit()
    }

}
