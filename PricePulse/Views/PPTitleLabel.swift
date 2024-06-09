//
//  PPTitleLabel.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import UIKit

class PPTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textAlignment = .center
        textColor = .systemBlue
        adjustsFontSizeToFitWidth = true

        font = UIFont.systemFont(ofSize: CGFloat(52), weight: .bold)
    }

}
