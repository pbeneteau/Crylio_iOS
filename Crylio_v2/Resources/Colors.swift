//
//  Colors.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import Foundation
import UIKit


struct Colors {
    
    struct Dark {
        
        struct Background {
            static let primary = UIColor(red: 0.01, green: 0.03, blue: 0.05, alpha: 1.00)
            static let secondary = UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 1.00)
            static let tertiary = UIColor(red: 0.14, green: 0.14, blue: 0.15, alpha: 1.00)
            static let quaternary = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1.00)
        }
        
        struct Label {
            static let primary = UIColor.white
            static let secondary = UIColor(red: 0.55, green: 0.58, blue: 0.62, alpha: 1.00)
            static let tertiary = UIColor(red: 0.56, green: 0.55, blue: 0.56, alpha: 1.00)
        }
        
        static let action = UIColor(red: 0.21, green: 0.53, blue: 0.96, alpha: 1.00)
        
        
        static let green = UIColor(red: 0.18, green: 0.74, blue: 0.52, alpha: 1.00)
        static let red = UIColor(red: 0.96, green: 0.27, blue: 0.36, alpha: 1.00)
    }
    
    struct Light {
    }
    
}
