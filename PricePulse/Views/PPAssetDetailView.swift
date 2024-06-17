//
//  PPAssetDetailView.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/11/24.
//
//

import UIKit

class PPAssetDetailView: UIView {
    
    let detailLabel = UILabel()
    let detailValue = UILabel()

    init(detailLabel: String, detailValue: String) {
        super.init(frame: .zero)
        self.detailLabel.text = detailLabel
        self.detailValue.text = detailValue
        
        configureView()
        configureLabel()
        configureValue()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 160),
            self.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    private func configureLabel() {
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailLabel.textColor = .lightText
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            detailLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func configureValue() {
        detailValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        detailValue.textColor = .white
        detailValue.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailValue)
        
        NSLayoutConstraint.activate([
            detailValue.topAnchor.constraint(equalTo: detailLabel.bottomAnchor),
            detailValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            detailValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            detailValue.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
