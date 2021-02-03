//
//  NavigationTopBarView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 31/01/2021.
//

import UIKit

class NavigationTopBarView: UIView {
    
    lazy var topBar = UIView()
    lazy var blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    var title = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        self.backgroundColor = .clear
        
        topBar.backgroundColor = .systemBackground
        blurredView.alpha = 0
        
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        addSubview(topBar)
        addSubview(blurredView)
        addSubview(title)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //manually set subview frames here
    }
    
    
    func hideTitle() {
        UIView.animate(withDuration: 0.3, delay:0, options: .beginFromCurrentState) {
            self.title.alpha = 0
            self.title.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(65)
                make.height.equalTo(20)
                make.width.equalTo(100)
            }
            
            self.layoutSubviews()
        }
    }
    
    func showTitle() {
        UIView.animate(withDuration: 0.3, delay:0, options: .beginFromCurrentState) {
            self.title.alpha = 1
            self.title.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(60)
                make.height.equalTo(20)
                make.width.equalTo(100)
            }
            
            self.layoutSubviews()
        }
    }
        
    
    override func updateConstraints() {
        
        //set subview constraints here
        
        topBar.snp.makeConstraints { make in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(91)
        }
        
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        title.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(65)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        super.updateConstraints()
    }
}
