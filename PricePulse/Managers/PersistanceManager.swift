//
//  PersistanceManager.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/10/24.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateFavoritesWith(favorite: FavoriteAsset, actionType: PersistanceActionType, completed: @escaping (PPError?) -> Void) {
        retrieveFavoritesAssets { result in
            switch result {
            case .success(let favorites):
                var retreievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retreievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retreievedFavorites.append(favorite)
                    
                case .remove:
                    retreievedFavorites.removeAll { $0.symbol == favorite.symbol}
                }
                
                completed(save(favorites: retreievedFavorites))
                
            case .failure(let error):
                return completed(error)
            }
        }
    }
    
    static func save(favorites: [FavoriteAsset]) -> PPError? {
        do {
            let encoder = JSONEncoder()
            let favorites = try encoder.encode(favorites)
            defaults.set(favorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func retrieveFavoritesAssets(completed: @escaping (Result<[FavoriteAsset], PPError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavoriteAsset].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToRetrieveFavorite))
        }
    }
}
