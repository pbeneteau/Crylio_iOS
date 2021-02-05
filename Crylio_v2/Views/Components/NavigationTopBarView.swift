//
//  NavigationTopBarView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 31/01/2021.
//

import UIKit

protocol BackButtonProtocol: NSObjectProtocol {
    func backButtonAction(sender: UIButton!)
}

class NavigationTopBarView: UIView {
    
    lazy var topBar = UIView()
    lazy var blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    lazy var backButton = UIButton(type: .custom)
    lazy var title = UILabel()
    
    weak var backButtonDelegate: BackButtonProtocol? = nil
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .clear
        
        topBar.backgroundColor = .systemBackground
        
        blurredView.alpha = 0
        
        // create chevron image
        let config = UIImage.SymbolConfiguration(pointSize: 25.0, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        
        backButton.setTitle("Back", for: .normal)
        backButton.setImage(image, for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonAction(sender:)), for: .touchUpInside)

        
        title.alpha = 0
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 17, weight: .medium)
        
        addSubview(blurredView)
        addSubview(topBar)
        addSubview(backButton)
        addSubview(title)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Manually set subview frames here
    }
    
    func hideTitle() {
        UIView.animate(withDuration: 0.3, delay: 0,options: [.curveEaseOut, .beginFromCurrentState], animations: {

            self.title.alpha = 0
            self.title.transform = CGAffineTransform(translationX: 0, y: 5)
        }, completion: nil)
    }
    
    func showTitle() {
        UIView.animate(withDuration: 0.3, delay: 0,options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.title.alpha = 1
            self.title.transform = CGAffineTransform(translationX: 0, y: -5)
        }, completion: nil)
    }
        
    
    override func updateConstraints() {
        
        // Set subview constraints here
        
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        topBar.snp.makeConstraints { make in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(91)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(6)
            make.top.equalTo(55)
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        title.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton).offset(5)
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        super.updateConstraints()
    }
    
    @objc func backButtonAction(sender: UIButton!) {
        self.backButtonDelegate?.backButtonAction(sender: sender)
    }
}
