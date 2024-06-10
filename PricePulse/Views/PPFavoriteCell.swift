//
//  FavoriteCell.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/10/24.
//

import UIKit

class PPFavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let assetName = PPTitleLabel()
    let assetPrice = PPTitleLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(assetName)
        addSubview(assetPrice)
        
        assetPrice.textAlignment = .right
        
        assetName.translatesAutoresizingMaskIntoConstraints = false
        assetPrice.translatesAutoresizingMaskIntoConstraints = false
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            assetName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            assetName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            assetName.heightAnchor.constraint(equalToConstant: 80),
            assetName.widthAnchor.constraint(equalToConstant: 120),
            
            assetPrice.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            assetPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            assetPrice.heightAnchor.constraint(equalToConstant: 80),
            assetPrice.widthAnchor.constraint(equalToConstant: 120),
            
        ])
    }
    
    func set(with asset: Asset) {
        assetName.text = asset.data.values.first?.name
        let assetPriceValue = asset.data.values.first?.quote.USD.price
        let assetPriceString = assetPriceValue?.formatToPriceString(double: assetPriceValue ?? 0.00)
        assetPrice.text = "$" + (assetPriceString ?? "n/a")
    }
}
