//
//  PPAssetChartView.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/15/24.
//

import SwiftUI
import Charts

struct MockAssetData: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

// Sample mock data
let sampleData: [MockAssetData] = [
    MockAssetData(date: Date().addingTimeInterval(-86400 * 6), price: 100),
    MockAssetData(date: Date().addingTimeInterval(-86400 * 5), price: 110),
    MockAssetData(date: Date().addingTimeInterval(-86400 * 4), price: 105),
    MockAssetData(date: Date().addingTimeInterval(-86400 * 3), price: 120),
    MockAssetData(date: Date().addingTimeInterval(-86400 * 2), price: 115),
    MockAssetData(date: Date().addingTimeInterval(-86400), price: 130),
    MockAssetData(date: Date(), price: 125)
]

struct PPAssetChartView: View {
    var data: [MockAssetData] = sampleData
    
    var body: some View {
        VStack {
            Text("Asset Price Over Time")
                .font(.headline)
                .padding()
            
            Chart(data) { dataPoint in
                LineMark(
                    x: .value("Date", dataPoint.date),
                    y: .value("Price", dataPoint.price)
                )
                .interpolationMethod(.catmullRom) // Optional: makes the line smooth
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 1))
            }
            .padding()
        }
    }
}

struct AssetChart_Previews: PreviewProvider {
    static var previews: some View {
        PPAssetChartView()
    }
}
