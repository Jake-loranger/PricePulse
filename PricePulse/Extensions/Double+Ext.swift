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
}
