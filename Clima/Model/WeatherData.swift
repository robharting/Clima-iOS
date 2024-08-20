//
//  WeatherData.swift
//  Clima
//
//  Created by Harting, R.P.G. (Rob) on 19/08/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

// Decodable is for JSON to Object. From Object -> JSON use Encodable protocol
// to combine use typealias to combine two protocols
struct WeatherData: Codable {
    let name: String
    let main: Main   
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
