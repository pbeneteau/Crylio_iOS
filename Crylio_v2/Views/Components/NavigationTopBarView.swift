//
//  NavigationTopBarView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 31/01/2021.
//

import UIKit

protocol BackButtonProtocol: NSObjectProtocol {
    func backButtonAction()
}

class NavigationTopBarView: UIView {
    
    lazy var topBar = UIView()
    
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    lazy var backButton = UIButton(type: .custom)
    lazy var title = UILabel()
    lazy var price = UILabel()
    
    var isCryptoInfoHidden = true
    var isBlurriedViewHidden = true
    
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
                
        topBar.backgroundColor = AppColors.background.primary
        
        blurredView.backgroundColor = AppColors.blur
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
        title.font = .systemFont(ofSize: 17, weight: .bold)
        
        price.alpha = 0
        price.textAlignment = .right
        price.textColor = AppColors.label.primary
        price.font = .systemFont(ofSize: 17, weight: .medium)
        
        addBottomBorder()
        
        addSubview(blurredView)
        addSubview(topBar)
        addSubview(backButton)
        addSubview(title)
        addSubview(price)
    }
    
    func hideCryptoInfo() {
        
        if isCryptoInfoHidden { return }
        isCryptoInfoHidden = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.title.alpha = 0
            self.title.transform = CGAffineTransform(translationX: 0, y: 5)
            self.price.alpha = 0
            self.price.transform = CGAffineTransform(translationX: 0, y: 5)
        }, completion: nil)
    }
    
    func showCryptoInfo() {
        
        if !isCryptoInfoHidden { return }
        isCryptoInfoHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.title.alpha = 1
            self.title.transform = CGAffineTransform(translationX: 0, y: -5)
            self.price.alpha = 1
            self.price.transform = CGAffineTransform(translationX: 0, y: -5)
        }, completion: nil)
        
    }
    
    @objc func backButtonAction(sender: UIButton!) {
        if let delegate = backButtonDelegate {
            delegate.backButtonAction()
        }
    }
    
    func addBottomBorder() {
        let border = UIView()
        border.backgroundColor = .systemGray.withAlphaComponent(0.2)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y:  blurredView.frame.size.height - 0.3, width:  blurredView.frame.size.width, height: 0.3)
        blurredView.contentView.addSubview(border)
    }
}


// MARK: - Constraints

extension NavigationTopBarView {
        
    override func updateConstraints() {
                
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
            make.height.equalTo(20)
            make.width.equalTo(title.intrinsicContentSize.width)
        }
        
        price.snp.remakeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(backButton).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(price.intrinsicContentSize.width)
        }
        
        super.updateConstraints()
    }
}
