//
//  PPTabBarControllerViewController.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/11/24.
//

import UIKit

class PPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        viewControllers = [createSearchVC(), createFavoritesVC()]
    }

    func createFavoritesVC() -> UINavigationController {
        let favoritesVC = PPFavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        favoritesNC.navigationBar.standardAppearance = appearance
        favoritesNC.navigationBar.scrollEdgeAppearance = appearance
        favoritesNC.navigationBar.compactAppearance = appearance
        favoritesNC.navigationBar.tintColor = .systemBlue
        
        return favoritesNC
    }
    
    
    func createSearchVC() -> UINavigationController {
        let searchVC = PPSearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        searchNC.navigationBar.standardAppearance = appearance
        searchNC.navigationBar.scrollEdgeAppearance = appearance
        searchNC.navigationBar.compactAppearance = appearance
        searchNC.navigationBar.tintColor = .systemBlue
        
        return searchNC
    }
}
