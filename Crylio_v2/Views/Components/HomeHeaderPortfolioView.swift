//
//  HomeHeaderPortfolioView.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 09/02/2021.
//

import UIKit

class HomeHeaderPortfolioView: UIView {
    
    lazy var circle1 = UIView()
    lazy var circle2 = UIView()
    lazy var circle3 = UIView()
    
    lazy var blurredView = UIView()
    
    var circle1OriginCenter: CGPoint!
    var circle2OriginCenter: CGPoint!
    var circle3OriginCenter: CGPoint!
    
    var loadingAnimation: UIViewPropertyAnimator!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
                
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        backgroundColor = .systemGray
        layer.masksToBounds = true
        
        circle1.backgroundColor = .systemGray2
        circle2.backgroundColor = .systemGray2
        circle3.backgroundColor = .systemGray2
        
        blurredView.addBurEffect()
        blurredView.addBurEffect()
        
        addSubview(circle1)
        addSubview(circle2)
        addSubview(circle3)
        
        addSubview(blurredView)
    }
    
    func setNewAnimationsForCircleViews() {
        
        let circle1NewPosition = getNewRandomPosition(center: circle1OriginCenter)
        let circle2NewPosition = getNewRandomPosition(center: circle2OriginCenter)
        let circle3NewPosition = getNewRandomPosition(center: circle3OriginCenter)
        
//        let circle1XNewScale = CGFloat.random(in: 0.8..<1)
//        let circle2XNewScale = CGFloat.random(in: 0.8..<1)
//        let circle3XNewScale = CGFloat.random(in: 0.8..<1)
//
//        let circle1YNewScale = CGFloat.random(in: 0.8..<1)
//        let circle2YNewScale = CGFloat.random(in: 0.8..<1)
//        let circle3YNewScale = CGFloat.random(in: 0.8..<1)
                
        let animator = UIViewPropertyAnimator(duration: 5, curve: .easeInOut)
                
        animator.addAnimations {
            self.circle1.transform = CGAffineTransform(translationX: circle1NewPosition.x - self.circle1OriginCenter.x, y: circle1NewPosition.y - self.circle1OriginCenter.y) //.concatenating(CGAffineTransform(scaleX: circle1XNewScale, y: circle1YNewScale))
            self.circle2.transform = CGAffineTransform(translationX: circle2NewPosition.x - self.circle2OriginCenter.x, y: circle2NewPosition.y - self.circle2OriginCenter.y) //.concatenating(CGAffineTransform(scaleX: circle2XNewScale, y: circle2YNewScale))
            self.circle3.transform = CGAffineTransform(translationX: circle3NewPosition.x - self.circle3OriginCenter.x, y: circle3NewPosition.y - self.circle3OriginCenter.y) //.concatenating(CGAffineTransform(scaleX: circle3XNewScale, y: circle3YNewScale))
        }
        
        
        animator.addCompletion { _ in
            self.setNewAnimationsForCircleViews()
            self.loadingAnimation.startAnimation()
        }

        loadingAnimation = animator
    }
    
    func getNewRandomPosition(center: CGPoint) -> CGPoint {
        let r = self.frame.width * CGFloat.random(in: 0.05..<0.15)
        
        let theta = CGFloat.random(in: 0..<1) * 2 * CGFloat.pi
        
        let x = center.x + r * cos(theta)
        let y = center.y + r * sin(theta)
        
        return CGPoint(x: x, y: y)
    }
    
    func getRandomCoordinates() -> [CGPoint] {
        
        var coordinates = [CGPoint]()
        
        coordinates.append(CGPoint(x: self.frame.width * 0.15, y: self.frame.height * 0.78))
        coordinates.append(CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.1))
        coordinates.append(CGPoint(x: self.frame.width * 0.85, y: self.frame.height * 0.657))
        
        return coordinates.shuffled()
    }
    
    func startLoadingAnimation() {
        
        setNewAnimationsForCircleViews()
        loadingAnimation.startAnimation()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print("STOP")
            self.loadingAnimation.stopAnimation(true)
            self.startGreenAnimation()
        }
    }
    
    func stopLoadingAnimation() {
        loadingAnimation.stopAnimation(true)
    }
    
    func startGreenAnimation() {
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)

        animator.addAnimations {
            self.circle1.transform = CGAffineTransform(translationX: self.circle3OriginCenter.x - self.circle1.center.x, y: self.circle3OriginCenter.y - self.circle1.center.y) //.concatenating(CGAffineTransform(scaleX: circle1XNewScale, y: circle1YNewScale))
            self.circle2.transform = CGAffineTransform(translationX: self.circle2OriginCenter.x - self.circle2.center.x, y: self.circle2OriginCenter.y - self.circle2.center.y) //.concatenating(CGAffineTransform(scaleX: circle2XNewScale, y: circle2YNewScale))
            self.circle3.transform = CGAffineTransform(translationX: self.circle1OriginCenter.x - self.circle3.center.x, y: self.circle1OriginCenter.y - self.circle3.center.y) //.concatenating(CGAffineTransform(scaleX: circle3XNewScale, y: circle3YNewScale))
            
            self.backgroundColor = .systemGreen
            self.circle1.backgroundColor = UIColor(red: 0.17, green: 0.59, blue: 0.43, alpha: 1.00)
            self.circle2.backgroundColor = UIColor(red: 0.17, green: 0.59, blue: 0.43, alpha: 1.00)
            self.circle3.backgroundColor = UIColor(red: 0.17, green: 0.59, blue: 0.43, alpha: 1.00)
        }
        animator.startAnimation()
    }
    
    
    override func updateConstraints() {
        
        let coordinates = getRandomCoordinates()
        
        circle1OriginCenter = coordinates[0]
        circle2OriginCenter = coordinates[1]
        circle3OriginCenter = coordinates[2]
                
        circle1.snp.remakeConstraints { make in
            make.width.height.equalTo(snp.width).multipliedBy(0.6)
            make.center.equalTo(circle1OriginCenter)
        }
        
        circle2.snp.remakeConstraints { make in
            make.width.height.equalTo(snp.width).multipliedBy(0.5)
            make.center.equalTo(circle2OriginCenter)
        }
        
        circle3.snp.remakeConstraints { make in
            make.width.height.equalTo(snp.width).multipliedBy(0.4)
            make.center.equalTo(circle3OriginCenter)
        }
        
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circle1.layer.cornerRadius = circle1.frame.size.width/2
        circle1.clipsToBounds = true
        
        circle2.layer.cornerRadius = circle2.frame.size.width/2
        circle2.clipsToBounds = true
        
        circle3.layer.cornerRadius = circle3.frame.size.width/2
        circle3.clipsToBounds = true
        
        setNeedsUpdateConstraints()
        
    }

}

extension UIView {
    
    func addBurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
