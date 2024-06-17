//
//  NetworkManager.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://pro-api.coinmarketcap.com"
    private let apiKey = "4b403583-4ed0-4b7c-91f2-8989ba68a154"
    
    private init() {}
    
    func getAssetData(for assetSymbol: String, completed: @escaping (Result<Asset, PPError>) -> Void) {
        let endpoint = baseUrl + "/v1/cryptocurrency/quotes/latest?symbol=\(assetSymbol)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAssetName))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let assetData = try decoder.decode(Asset.self, from: data)
                completed(.success(assetData))
            } catch {
                completed(.failure(.invalidResponse))
            }
            
        }
        task.resume()
    }
}
