//
//  SortOrderButton.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 02/06/2021.
//

import UIKit
import Lottie


fileprivate enum ProgressKeyFrames: CGFloat {
    
    case start_1 = 20
    case end_1 = 40
    case start_2 = 105
    case end_2 = 125
  }

class SortOrderButton: RoundedCornersView {
    
    lazy var arrowView = AnimationView(name: "62876-arrow-button")
    
    var ascendingOrder = true

    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .label.withAlphaComponent(0.1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        addGestureRecognizer(tap)
        
        arrowView.contentMode = .scaleAspectFit
        arrowView.loopMode = .playOnce
        arrowView.animationSpeed = 2
        
        let keypath = AnimationKeypath(keys: ["**", "**", "**", "Color"])
        let colorProvider = ColorValueProvider(UIColor.systemBlue.lottieColorValue)
        arrowView.setValueProvider(colorProvider, keypath: keypath)
        
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        
        addSubview(arrowView)
    }
    
    @objc func onTap(_ sender: UIButton) {
        
        ascendingOrder = !ascendingOrder
        
        if !ascendingOrder {
            arrowView.play(fromFrame: ProgressKeyFrames.start_1.rawValue, toFrame: ProgressKeyFrames.end_1.rawValue, loopMode: .none)
        } else {
            arrowView.play(fromFrame: ProgressKeyFrames.start_2.rawValue, toFrame: ProgressKeyFrames.end_2.rawValue, loopMode: .none)
        }
        
        print("sort order:", ascendingOrder == false ? "descending": "ascending")
    }
}


// MARK: - Constraints

extension SortOrderButton {
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        arrowView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.8)
        }
        
        layer.cornerRadius = frame.height/2
    }
}
