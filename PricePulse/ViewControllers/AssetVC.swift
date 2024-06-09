//
//  AssetVC.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import UIKit

class AssetVC: UIViewController {
    
    var assetName: String!
    let titleLabel = PPTitleLabel()
    var assetData: Asset?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTitleLabel()
        fetchAssetData(for: assetName)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = assetName
        titleLabel.textAlignment = .left
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func fetchAssetData(for assetName: String) {
        // Show Loading View
        NetworkManager.shared.getAssetData(for: assetName) { [weak self] result in
            guard let self = self else { return }
            
            // Dismiss loading view
            
            switch result {
            case .success(let assetData):
                self.assetData = assetData
                return
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
}
