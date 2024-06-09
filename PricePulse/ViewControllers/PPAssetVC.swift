//
//  PPAssetVC.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import UIKit

class PPAssetVC: UIViewController {
    
    var assetName: String!
    let titleLabel = PPTitleLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        fetchAssetData(for: assetName)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
    }
    
    private func fetchAssetData(for assetName: String) {
        showLoadingView()
        
        NetworkManager.shared.getAssetData(for: assetName) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let asset):
                guard let _ = asset.data.values.first else {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    self.presentErrorOnMainThread(title: "Invalid Asset Name", message: "Please enter a valid asset name.", buttonTitle: "Ok")
                    return
                }
                
                DispatchQueue.main.async {
                    self.configureUIElements(with: asset)
                }
                return
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
    
    private func configureUIElements(with assetData: Asset) {
        if let assetData = assetData.data.values.first {
            configureTitleLabel(name: assetData.name)
            configurePriceView(price: assetData.quote.USD.price)
            configureRankView(rank: assetData.cmcRank)
            configureMarketCapView(marketCap: assetData.quote.USD.marketCap)
            configureSupplyView(circulatingSupply: (assetData.circulatingSupply / assetData.totalSupply * 100))
        }
    }
    
    func configureTitleLabel(name: String) {
        view.addSubview(titleLabel)
        titleLabel.text = name
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configurePriceView(price: Double) {
        let priceView = UIView()
        priceView.backgroundColor = .systemBlue
        priceView.layer.cornerRadius = 8
        priceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceView)
        
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        priceLabel.textColor = .lightText
        priceLabel.text = "Price:"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceView.addSubview(priceLabel)
        
        let priceValue = UILabel()
        priceValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        priceValue.textColor = .white
        let formattedPrice = price.formatToPriceString(double: price)
        priceValue.text = "$\(formattedPrice ?? "")"
        priceValue.translatesAutoresizingMaskIntoConstraints = false
        priceView.addSubview(priceValue)
        
        
        NSLayoutConstraint.activate([
            priceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceView.widthAnchor.constraint(equalToConstant: 170),
            priceView.heightAnchor.constraint(equalToConstant: 100),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -15),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceValue.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            priceValue.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 15),
            priceValue.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -15),
            priceValue.bottomAnchor.constraint(equalTo: priceView.bottomAnchor)
        ])
    }
    
    func configureRankView(rank: Int) {
        let rankView = UIView()
        rankView.backgroundColor = .systemBlue
        rankView.layer.cornerRadius = 8
        rankView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rankView)
        
        let rankLabel = UILabel()
        rankLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        rankLabel.textColor = .lightText
        rankLabel.text = "Rank:"
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankView.addSubview(rankLabel)
        
        let rankValue = UILabel()
        rankValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        rankValue.textColor = .white
        rankValue.text = "#\(rank)"
        rankValue.translatesAutoresizingMaskIntoConstraints = false
        rankView.addSubview(rankValue)
        
        
        NSLayoutConstraint.activate([
            rankView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            rankView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rankView.widthAnchor.constraint(equalToConstant: 170),
            rankView.heightAnchor.constraint(equalToConstant: 100),
            
            rankLabel.topAnchor.constraint(equalTo: rankView.topAnchor, constant: 10),
            rankLabel.leadingAnchor.constraint(equalTo: rankView.leadingAnchor, constant: 15),
            rankLabel.trailingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: -15),
            rankLabel.heightAnchor.constraint(equalToConstant: 20),
            
            rankValue.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankValue.leadingAnchor.constraint(equalTo: rankView.leadingAnchor, constant: 15),
            rankValue.trailingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: -15),
            rankValue.bottomAnchor.constraint(equalTo: rankView.bottomAnchor)
        ])
    }
    
    func configureMarketCapView(marketCap: Double) {
        let marketCapView = UIView()
        marketCapView.backgroundColor = .systemBlue
        marketCapView.layer.cornerRadius = 8
        marketCapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(marketCapView)
        
        let marketCapLabel = UILabel()
        marketCapLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        marketCapLabel.textColor = .lightText
        marketCapLabel.text = "Market Cap:"
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapView.addSubview(marketCapLabel)
        
        let marketCapValue = UILabel()
        marketCapValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        marketCapValue.textColor = .white
        let formattedPrice = marketCap.formatToPriceString(double: marketCap)
        marketCapValue.text = "$\(formattedPrice ?? "")"
        marketCapValue.translatesAutoresizingMaskIntoConstraints = false
        marketCapView.addSubview(marketCapValue)
        
        
        NSLayoutConstraint.activate([
            marketCapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 145),
            marketCapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            marketCapView.widthAnchor.constraint(equalToConstant: 170),
            marketCapView.heightAnchor.constraint(equalToConstant: 100),
            
            marketCapLabel.topAnchor.constraint(equalTo: marketCapView.topAnchor, constant: 10),
            marketCapLabel.leadingAnchor.constraint(equalTo: marketCapView.leadingAnchor, constant: 15),
            marketCapLabel.trailingAnchor.constraint(equalTo: marketCapView.trailingAnchor, constant: -15),
            marketCapLabel.heightAnchor.constraint(equalToConstant: 20),
            
            marketCapValue.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor),
            marketCapValue.leadingAnchor.constraint(equalTo: marketCapView.leadingAnchor, constant: 15),
            marketCapValue.trailingAnchor.constraint(equalTo: marketCapView.trailingAnchor, constant: -15),
            marketCapValue.bottomAnchor.constraint(equalTo: marketCapView.bottomAnchor)
        ])
    }
    
    func configureSupplyView(circulatingSupply: Double) {
        let supplyView = UIView()
        supplyView.backgroundColor = .systemBlue
        supplyView.layer.cornerRadius = 8
        supplyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(supplyView)
        
        let supplyLabel = UILabel()
        supplyLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        supplyLabel.textColor = .lightText
        supplyLabel.text = "Circulating Supply:"
        supplyLabel.translatesAutoresizingMaskIntoConstraints = false
        supplyView.addSubview(supplyLabel)
        
        let supplyValue = UILabel()
        supplyValue.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        supplyValue.textColor = .white
        let formattedCirculatingSupply = String(circulatingSupply.rounded())
        supplyValue.text = "% \(formattedCirculatingSupply)"
        supplyValue.translatesAutoresizingMaskIntoConstraints = false
        supplyView.addSubview(supplyValue)
        
        
        NSLayoutConstraint.activate([
            supplyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 145),
            supplyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            supplyView.widthAnchor.constraint(equalToConstant: 170),
            supplyView.heightAnchor.constraint(equalToConstant: 100),
            
            supplyLabel.topAnchor.constraint(equalTo: supplyView.topAnchor, constant: 10),
            supplyLabel.leadingAnchor.constraint(equalTo: supplyView.leadingAnchor, constant: 15),
            supplyLabel.trailingAnchor.constraint(equalTo: supplyView.trailingAnchor, constant: -15),
            supplyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            supplyValue.topAnchor.constraint(equalTo: supplyLabel.bottomAnchor),
            supplyValue.leadingAnchor.constraint(equalTo: supplyView.leadingAnchor, constant: 15),
            supplyValue.trailingAnchor.constraint(equalTo: supplyView.trailingAnchor, constant: -15),
            supplyValue.bottomAnchor.constraint(equalTo: supplyView.bottomAnchor)
        ])
    }
}
