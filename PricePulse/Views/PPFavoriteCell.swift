//
//  FavoriteCell.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/10/24.
//

import UIKit

class PPFavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let assetName = PPCellTitleLabel()
    let assetPrice = PPCellTitleLabel()
    let assetPriceChange = PPCellPriceChangeTitle()

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
        addSubview(assetPriceChange)
        
        assetPrice.textAlignment = .right
        
        assetName.translatesAutoresizingMaskIntoConstraints = false
        assetPrice.translatesAutoresizingMaskIntoConstraints = false
        assetPriceChange.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            assetName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            assetName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            assetName.trailingAnchor.constraint(equalTo: assetPrice.leadingAnchor),
            assetName.heightAnchor.constraint(equalToConstant: 40),
            
            assetPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            assetPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            assetPrice.leadingAnchor.constraint(equalTo: assetName.trailingAnchor),
            assetPrice.heightAnchor.constraint(equalToConstant: 40),
            
            assetPriceChange.topAnchor.constraint(equalTo: assetPrice.bottomAnchor),
            assetPriceChange.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            assetPriceChange.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            assetPriceChange.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(with favorite: FavoriteAsset) {
        NetworkManager.shared.getAssetData(for: favorite.symbol) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let asset):
                DispatchQueue.main.async {
                    self.assetName.text = asset.data.values.first?.name
                    
                    let assetPriceValue = asset.data.values.first?.quote.USD.price
                    let assetPriceString = assetPriceValue?.formatToPriceString(double: assetPriceValue ?? 0.00)
                    self.assetPrice.text = "$" + (assetPriceString ?? "n/a")
                    
                    guard let assetPriceChangeValue = asset.data.values.first?.quote.USD.percentChange24h else {
                        self.assetPriceChange.text = "N/A"
                        return
                    }
                    
                    self.assetPriceChange.text =  String(format: "%.2f", assetPriceChangeValue) + "%"
                    if assetPriceChangeValue == 0 {
                        self.assetPriceChange.textColor = .systemGray
                    } else if assetPriceChangeValue > 0 {
                        self.assetPriceChange.textColor = .systemGreen
                    } else {
                        self.assetPriceChange.textColor = .systemRed
                    }
                }
                return
            case .failure(let error):
                return
            }
        }
        
//        assetName.text = asset.data.values.first?.name
        
    }
}
