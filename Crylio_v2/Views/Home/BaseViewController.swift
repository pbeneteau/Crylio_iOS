//
//  BaseViewController.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 07/05/2021.
//

import UIKit



class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initColors()
    }
    
    
    func initColors() {
        
        view.backgroundColor = AppColors.background.primary
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        initColors()
    }
    
}
