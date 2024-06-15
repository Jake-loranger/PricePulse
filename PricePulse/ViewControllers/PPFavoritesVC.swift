//
//  PPFavoritesVC.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/8/24.
//

import UIKit

class PPFavoritesVC: UIViewController {
    
    let tableView = UITableView()
    var favorites: [FavoriteAsset] = []
    var favoritesData: [Asset] = []
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavoritesData()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFavoritesData), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PPFavoriteCell.self, forCellReuseIdentifier: PPFavoriteCell.reuseID)
    }
    
    private func getFavorites() {
        PersistanceManager.retrieveFavoritesAssets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let assets):
                self.favorites = assets
                return
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
    
    
    @objc private func refreshFavoritesData() {
        getFavorites()
        favoritesData.removeAll()

        for favorite in favorites {
            NetworkManager.shared.getAssetData(for: favorite.symbol) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let asset):
                    self.favoritesData.append(asset)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                        self.refreshControl.endRefreshing()
                    }
                    return
                case .failure(let error):
                    self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                    return
                }
            }
        }
    }
}

extension PPFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PPFavoriteCell.reuseID) as! PPFavoriteCell
        let favoriteData = favoritesData[indexPath.row]
        cell.set(with: favoriteData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        /* Right now, the incorect asset is being deleted from userDefaults because the Cell's favoriteAsset indexRow is different than the cells favoriteData indexRow */
        let favorite = favorites[indexPath.row]
        favoritesData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateFavoritesWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            
            self.presentErrorOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = PPAssetVC()
        destVC.assetName = favorite.symbol
        navigationController?.pushViewController(destVC, animated: true)
    }
}
