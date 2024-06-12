//
//  PPCellPriceChangeTitle.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/12/24.
//

import UIKit

class PPCellPriceChangeTitle: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textAlignment = .right
        font = UIFont.systemFont(ofSize: CGFloat(16), weight: .semibold)
    }

}
