//
//  City.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

struct CityModel {
    
    let name: String
    //let weatherImage: UIImage
    let description: String
    let conditionId: Int
    let currentTemp: Int
    let maxTemp: Int
    let minTemp: Int
    var saved:Bool = false
    let feelsLike: Int
    let humidity: Int
    let windSpeed: Int
    let visibility: Int
    
    var weatherCondition: String {
        switch conditionId {
        case 200...232:
            return "thunder-cloudy"
        case 300...321:
            return "rainy"
        case 500...531:
            return "rainy"
        case 600...622:
            return "snowy"
        case 701...781:
            return "windy-cloudy"
        case 800:
            return "sunny"
        case 801...804:
            return "cloudy"
        default:
            return "cloud"
        }
    }
    
}
    

//weather conditions
/*
 sunrise
 windy
 snow
 sunset
 cloudy
 clear
 thunderstorms
 partly cloudy
 rain
 heavy rain
 drizzle
 cloudy
 clear
 fog
 tornado
 */
