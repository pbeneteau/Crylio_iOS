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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let aPath = UIBezierPath()
        
        aPath.lineWidth = 2
        aPath.lineCapStyle = .round
        aPath.lineJoinStyle = .round

        aPath.move(to: CGPoint(x: 5.31, y: 10.06))
        aPath.addLine(to: CGPoint(x: 11.5, y: 16.71))
        aPath.close()

        aPath.move(to: CGPoint(x: 17.69, y: 10.06))
        aPath.addLine(to: CGPoint(x: 11.5, y: 16.71))
        aPath.close()

        UIColor.systemBlue.set()
        
        aPath.stroke()
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .label.withAlphaComponent(0.1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        addGestureRecognizer(tap)
        
    }
    
    @objc func onTap(_ sender: UIButton) {
        
        ascendingOrder = !ascendingOrder
        
        print("sort order:", ascendingOrder == false ? "descending": "ascending")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height/2
    }
}

