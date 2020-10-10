//
//  CityData.swift
//  FinStructure
//
//  Created by Louis An on 5/10/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation

struct CityData: Codable {
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
    let feels_like: Double
    let humidity: Int
    let wind_speed: Double
    let visibility: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Codable {
    let min: Double
    let max: Double
}
