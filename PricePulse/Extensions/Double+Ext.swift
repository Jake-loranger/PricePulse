//
//  Double+Ext.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import Foundation

extension Double {
    func formatToPriceString(double: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesSignificantDigits = true
        numberFormatter.minimumSignificantDigits = 1
        numberFormatter.maximumSignificantDigits = 4
        
        return numberFormatter.string(from: NSNumber(value: double))
    }
    
    func formatToMarketCapString(double: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0
        
        let absValue = abs(double)
        let suffixes = ["", "K", "M", "B", "T"]
        var index = 0
        
        var value = absValue
        while value >= 1000 && index < suffixes.count - 1 {
            value /= 1000
            index += 1
        }
        
        numberFormatter.positiveSuffix = suffixes[index]
        numberFormatter.negativeSuffix = suffixes[index]
        
        return numberFormatter.string(from: NSNumber(value: double / pow(1000.0, Double(index))))
    }
}
