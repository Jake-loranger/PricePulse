//
//  PPTextField.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import UIKit

class PPTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        textAlignment = .center
        placeholder = "Enter an asset symbol"
        returnKeyType = .go
    }

}
