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
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getAssetData(for: assetName) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let asset):
                PersistanceManager.updateFavoritesWith(favorite: asset, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentErrorOnMainThread(title: "Success!", message: "Asset was saved to favorites", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentErrorOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
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
        let formattedPrice = price.formatToPriceString(double: price)
        let priceValue = "$\(formattedPrice ?? "")"
        
        let priceView = PPAssetDetailView(detailLabel: "Price", detailValue: priceValue)
        view.addSubview(priceView)
        
        NSLayoutConstraint.activate([
            priceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            priceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }

    
    func configureRankView(rank: Int) {
        let rankValue = "#\(rank)"
        let rankView = PPAssetDetailView(detailLabel: "Rank", detailValue: rankValue)
        view.addSubview(rankView)
        
        NSLayoutConstraint.activate([
            rankView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            rankView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    
    func configureMarketCapView(marketCap: Double) {
        let formattedPrice = marketCap.formatToMarketCapString(double: marketCap)
        let marketCapValue = "$\(formattedPrice ?? "")"
        let marketCapView = PPAssetDetailView(detailLabel: "Market Cap", detailValue: marketCapValue)
        view.addSubview(marketCapView)
        
        print(formattedPrice)
        print(marketCap)
        
        NSLayoutConstraint.activate([
            marketCapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 145),
            marketCapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    
    func configureSupplyView(circulatingSupply: Double) {
        let formattedPrice = circulatingSupply.formatToPriceString(double: circulatingSupply)
        let circulatingSupplyValue = "%\(formattedPrice ?? "")"
        let circulatingSupplyView = PPAssetDetailView(detailLabel: "Circulating Supply", detailValue: circulatingSupplyValue)
        view.addSubview(circulatingSupplyView)
        
        NSLayoutConstraint.activate([
            circulatingSupplyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 145),
            circulatingSupplyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
}
