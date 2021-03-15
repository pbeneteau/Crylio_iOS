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
    
    var balance: Float
    var amount: Float
    
    var price: Float
    var change: Float
    
    var iconName: String {
        didSet {
            icon = UIImage(named: iconName)!
        }
    }
    var icon: UIImage?
    
    
    func balanceToString() -> String {
        return usdFormat(balance)
    }
    
    func amountToString() -> String {
        return String(amount)
    }
    
    func priceToString() -> String {
        return usdFormat(price)
    }
    
    func changeToString() -> String {
        return percentFormat(change)
    }
    
    
    init?(id: Int,
          name: String,
          slug: String,
          symbol: String,
          description: String,
          balance: Float,
          amount: Float,
          price: Float,
          change: Float,
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
