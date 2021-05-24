//
//  RoundCornerButton.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 21/05/2021.
//

import UIKit

class RoundCornerButton: UIButton {
    
    /// Renders vertical gradient if true else horizontal
    public var verticalGradient: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    /// Start color of the gradient
    public var startColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /// End color of the gradient
    public var endColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /// Border color of the view
    public var borderColor: UIColor? = nil {
        didSet {
            updateUI()
        }
    }
    
    /// Border width of the view
    public var borderWidth: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    /// Corner radius of the view
    public var cornerRadius: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Variables
    /// Closure is called on click event of the button
    public var onClick = { () }
    
    private var gradientlayer = CAGradientLayer()
    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        gradientlayer = CAGradientLayer()
        updateUI()
        layer.addSublayer(gradientlayer)
    }
    
    // MARK: - Update frame
    private func updateFrame() {
        gradientlayer.frame = bounds
    }
    
    // MARK: - Update UI
    private func updateUI() {
        
        semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 10)
        
        addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
        
        gradientlayer.colors = [startColor.cgColor, endColor.cgColor]
        
        if verticalGradient {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 0, y: 1)
        } else {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 1, y: 0)
        }
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor ?? tintColor.cgColor
        
        if cornerRadius > 0 {
            layer.masksToBounds = true
        }
        updateFrame()
    }
    
    // MARK: - On Click
    @objc private func clickAction(button: UIButton) {
        onClick()
    }
    
}
