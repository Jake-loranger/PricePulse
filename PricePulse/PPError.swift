//
//  PPError.swift
//  PricePulse
//
//  Created by Jacob  Loranger on 6/9/24.
//

import Foundation

enum PPError: String, Error {
    case invalidAssetName = "The asset you have entered is not in the database. Please enter a new asset."
    case unableToComplete = "Unable to complete request. Check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
}
