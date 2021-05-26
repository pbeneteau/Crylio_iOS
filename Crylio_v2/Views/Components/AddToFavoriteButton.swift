//
//  AddToFavoriteButton.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 25/05/2021.
//

import UIKit

protocol AddToFavoriteButtonDelegate: NSObjectProtocol {
    func favoriteStateDidChange(favorite: Bool)
}

class AddToFavoriteButton: RoundedCornersView {
    
    lazy var starView = UIImageView(image: UIImage(named: "starEmptyIcon"))
    
    lazy var added = false
    
    weak var delegate: AddToFavoriteButtonDelegate!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    
    private func commonInit() {
        
        layer.cornerRadius = 7
        
        layer.borderWidth = 1
        layer.borderColor = AppColors.label.secondary.cgColor
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(_:))))
        
        addSubview(starView)
    }
    
    @objc private func didTapView(_ sender: UIView) {
        
        added = !added

        if let delegate = delegate {
            delegate.favoriteStateDidChange(favorite: added)
        }
        
        if !added {
            starView.image = UIImage(named: "starEmptyIcon")
            animateBorder(newWidth: 1, duration: 0.2)
            starView.transform = CGAffineTransform.identity
        } else {
            starView.image = UIImage(named: "starIcon")
            animateBorder(newWidth: 0, duration: 0.1)
            animateStarSizeIncrease(scaleFactor: 1.38, duration: 0.3)
        }
        print((added ? "added to" : "removed from") + " favourites")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func animateBorder(newWidth: CGFloat, duration: Double) {
        
        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = layer.borderWidth
        borderWidthAnimation.toValue = newWidth
        borderWidthAnimation.duration = duration
        layer.add(borderWidthAnimation, forKey: "borderWidth")
        layer.borderWidth = newWidth
    }
    
    func animateStarSizeIncrease(scaleFactor: CGFloat, duration: Double) {
        
        UIView.animate(withDuration: duration/2, animations: {
            
            self.starView.transform = CGAffineTransform(scaleX: scaleFactor*1.2, y: scaleFactor*1.2)
        },
        completion: { _ in
            UIView.animate(withDuration: duration/2) {
                self.starView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            }
        })
    }
        
}


// MARK: - Constraints

extension AddToFavoriteButton {
    
    override func updateConstraints() {
        
        starView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        super.updateConstraints()

    }
}
