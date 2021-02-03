//
//  Cryptocurrency.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 27/01/2021.
//

import Foundation
import UIKit

class Cryptocurrency {
    var id: Int
    var name: String
    var slug: String
    var symbol: String
    var description: String
    
    var balance: Double
    var amount: Double
    
    var price: Double
    var change: Double
    
    var iconName: String {
        didSet {
            icon = UIImage(named: iconName)!
        }
    }
    var icon: UIImage?
    
    
    func balanceToString() -> String {
        return "$\(balance)"
    }
    
    func amountToString() -> String {
        return String(amount)
    }
    
    func priceToString() -> String {
        return "$\(price)"
    }
    
    func changeToString() -> String {
        return "\(change) %"
    }
    
    
    init?(id: Int,
          name: String,
          slug: String,
          symbol: String,
          description: String,
          balance: Double,
          amount: Double,
          price: Double,
          change: Double,
          iconName: String) {
        self.id = id
        self.name = name
        self.slug = slug
        self.symbol = symbol
        self.description = description
        self.balance = balance
        self.amount = amount
        self.price = price
        self.change = change
        self.iconName = iconName
        
    }
}
