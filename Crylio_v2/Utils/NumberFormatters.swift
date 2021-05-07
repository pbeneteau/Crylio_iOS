//
//  NumberFormatters.swift
//  Crylio_v2
//
//  Created by Paul Bénéteau on 15/03/2021.
//

import Foundation


func usdFormat(_ float: Float) -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    
    let number = NSNumber(value: float)
    
    return formatter.string(from: number)!
}

func percentFormat(_ float: Float) -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2

    
    let number = NSNumber(value: float)
    
    if float < 0 {
        return "-" + formatter.string(from: number)! + "%"
    }
    
    return "+" + formatter.string(from: number)! + "%"
}

func amountFormat(_ float: Float) -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 6
    
    let number = NSNumber(value: float)
    
    return formatter.string(from: number)!
}
