//
//  TransactionsHeaderViewCell.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 05/04/2021.
//

import UIKit

class TransactionsHeaderView: UITableViewHeaderFooterView {
    
    static let reuseId = "HeaderView"

    var title = UILabel()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        title.text = "test"
        
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
