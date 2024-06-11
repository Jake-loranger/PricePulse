//
//  PPAssetDetailView.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/11/24.
//
//
//import UIKit
//
//class PPAssetDetailView: UIView {
//    let detailLabel = UILabel()
//    let detailValue = UILabel()
//
//    init(detailLabel: String, detailValue: String) {
//        super.init(frame: .zero)
//        self.detailLabel.text = detailLabel
//        self.detailValue.text = detailValue
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//    priceView.backgroundColor = .systemBlue
//    priceView.layer.cornerRadius = 8
//    priceView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(priceView)
//
//    let priceLabel = UILabel()
//    priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//    priceLabel.textColor = .lightText
//    priceLabel.text = "Price:"
//    priceLabel.translatesAutoresizingMaskIntoConstraints = false
//    priceView.addSubview(priceLabel)
//
//    let priceValue = UILabel()
//    priceValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
//    priceValue.textColor = .white
//    let formattedPrice = price.formatToPriceString(double: price)
//    priceValue.text = "$\(formattedPrice ?? "")"
//    priceValue.translatesAutoresizingMaskIntoConstraints = false
//    priceView.addSubview(priceValue)
//
//}
