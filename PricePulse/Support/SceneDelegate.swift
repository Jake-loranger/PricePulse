//
//  SceneDelegate.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/8/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
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
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        tabBar.viewControllers = [createSearchVC(), createFavoritesVC()]
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

