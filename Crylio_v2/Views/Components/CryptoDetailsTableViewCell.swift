//
//  CryptoDetailsTableViewCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 01/02/2021.
//

import UIKit

class CryptoDetailsTableViewCell: UITableViewCell {
    
    lazy var boxView = RoundedCornersView()
    lazy var content = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        boxView.layer.cornerRadius = 10
        boxView.backgroundColor = .systemGray6
        
        addSubview(boxView)
        boxView.addSubview(content)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateConstraints() {
        
        boxView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.center.equalToSuperview()
            make.height.equalToSuperview().offset(-15)
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

}
