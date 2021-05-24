//
//  Colors.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import Foundation
import UIKit


class AppColors {
    
    
    struct background {
        static var primary: UIColor { return UIColor.systemGray6 | UIColor(red: 0.07, green: 0.09, blue: 0.13, alpha: 1.00)}
        static var secondary: UIColor { return UIColor.white | UIColor(red: 0.09, green: 0.11, blue: 0.15, alpha: 1.00)}
        static var tertiary: UIColor { return UIColor(red: 0.12, green: 0.13, blue: 0.17, alpha: 1.00) }
        static var quaternary: UIColor { return UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1.00) }
    }
    
    struct label {
        static var primary: UIColor { return UIColor.label }
        static var secondary: UIColor { return UIColor(red: 0.45, green: 0.48, blue: 0.52, alpha: 1.00) }
        static var tertiary: UIColor { return UIColor(red: 0.56, green: 0.55, blue: 0.56, alpha: 1.00) }
    }
    
    static let action = UIColor(red: 0.21, green: 0.53, blue: 0.96, alpha: 1.00)
    
    static let green = UIColor(red: 0.18, green: 0.74, blue: 0.52, alpha: 1.00)
    static let red = UIColor(red: 0.96, green: 0.27, blue: 0.36, alpha: 1.00)
    
    static let icon = UIColor.label
    
    static let chart = [UIColor(red: 0.21, green: 0.47, blue: 0.80, alpha: 1.00),
                              UIColor(red: 0.86, green: 0.55, blue: 0.07, alpha: 1.00),
                              UIColor(red: 0.71, green: 0.38, blue: 0.78, alpha: 1.00),
                              UIColor(red: 0.22, green: 0.78, blue: 0.42, alpha: 1.00),
                              UIColor(red: 0.62, green: 0.92, blue: 0.33, alpha: 1.00),
                              UIColor(red: 0.00, green: 0.75, blue: 0.78, alpha: 1.00),
                              UIColor(red: 0.85, green: 0.20, blue: 0.56, alpha: 1.00),
                              UIColor(red: 0.87, green: 0.75, blue: 0.00, alpha: 1.00),
                              UIColor(red: 0.15, green: 0.55, blue: 0.43, alpha: 1.00),
                              UIColor(red: 0.56, green: 0.54, blue: 0.98, alpha: 1.00)]
    
    static let blur = .clear | .systemBlue.withAlphaComponent(0.1)
    
    static let buttonActiveBackground = .systemBlue.withAlphaComponent(0.3) | .systemBlue.withAlphaComponent(0.2)
     
}

infix operator |: AdditionPrecedence
public extension UIColor {
    
    /// Easily define two colors for both light and dark mode.
    /// - Parameters:
    ///   - lightMode: The color to use in light mode.
    ///   - darkMode: The color to use in dark mode.
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

public extension UILabel {
    
    func setSpannedColor (fullText : String , changeText : String, color: UIColor) {
        
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        self.attributedText = attribute
    }
}
