//
//  Asset.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import Foundation

struct Asset: Codable {
    let data: [String: AssetData]
}

struct AssetData: Codable {
    let name: String
    let symbol: String
    let circulatingSupply: Double
    let totalSupply: Double
    let cmcRank: Int
    let quote: Quote
    
    private enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case cmcRank = "cmc_rank"
        case quote
    }
}

struct Quote: Codable {
    let USD: USD
}

struct USD: Codable {
    let price: Double
    let volume24h: Double
    let volumeChange24h: Double
    let percentChange24h: Double
    let marketCap: Double
    
    private enum CodingKeys: String, CodingKey {
        case price
        case volume24h = "volume_24h"
        case volumeChange24h = "volume_change_24h"
        case percentChange24h = "percent_change_24h"
        case marketCap = "market_cap"
    }
}
