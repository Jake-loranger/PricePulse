//
//  HistoricalData.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/16/24.
//

import Foundation

struct HistoricalData: Codable, Hashable {
    let data: [String: HistoricalData]
}

struct Quotes: Codable, Hashable {
    let name: String
    let symbol: String
    let quotes: [Quote]
}
