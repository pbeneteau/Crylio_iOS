//
//  CustomSearchBar.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 21/05/2021.
//

import UIKit


class CustomSearchBar: RoundedCornersView {

    lazy var searchBar = UISearchBar()
    
    
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
        
        backgroundColor = AppColors.background.secondary
        searchBar.barTintColor = AppColors.background.secondary
        searchBar.backgroundColor = AppColors.background.secondary
        
        layer.cornerRadius = 10
        
        searchBar.searchTextField.font = .systemFont(ofSize: 15.0)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.backgroundColor = AppColors.background.secondary
            
            if let backgroundview = textfield.subviews.first {
                
                backgroundview.backgroundColor = AppColors.background.secondary
            }
        }
        
        addSubview(searchBar)
    }
    
}


// MARK: - Constraints

extension CustomSearchBar {
    
    override func updateConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(5)
            make.top.bottom.equalToSuperview()
        }
        
        super.updateConstraints()

    }
}
