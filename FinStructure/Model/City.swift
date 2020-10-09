//
//  City.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit

class City {
    
    var name: String
    var weatherImage: UIImage
    var currentTemp: Int
    var maxTemp: Int
    var minTemp: Int
    var saved:Bool = false
    var weatherCondition: String
    var feelsLike: Int
    var humidity: Int
    var windSpeed: Int
    var visibility: Int
    
    
    
    
    init(name: String, weatherImage: UIImage, currentTemp: Int, maxTemp: Int, minTemp: Int, saved: Bool, weatherCondition: String, feelsLike: Int, humidity: Int, windSpeed: Int, visibility: Int) {
        self.name = name
        self.weatherImage = weatherImage
        self.currentTemp = currentTemp
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.saved = saved
        self.weatherCondition = weatherCondition
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.visibility = visibility
    }
    
    
    //Add data into array
     class func createArray() -> [City]{
        var cities: [City] = []
        
        let city1 = City(name: "Melbourne", weatherImage: #imageLiteral(resourceName: "windy"), currentTemp: 14, maxTemp: 20, minTemp: 10, saved: false, weatherCondition: "Windy", feelsLike: 12, humidity: 50, windSpeed: 5, visibility: 10)
        let city2 = City(name: "Sydney", weatherImage: #imageLiteral(resourceName: "sunny-cloudy"), currentTemp: 22, maxTemp: 25, minTemp: 10, saved: false, weatherCondition: "Partly Cloudy", feelsLike: 18, humidity: 90, windSpeed: 3, visibility: 12)
        let city3 = City(name: "Perth", weatherImage: #imageLiteral(resourceName: "thunder"), currentTemp: 11, maxTemp: 12, minTemp: 8, saved: false, weatherCondition: "Thunderstorms", feelsLike: 4, humidity: 90, windSpeed: 10, visibility: 3 )
        let city4 = City(name: "Canberra", weatherImage: #imageLiteral(resourceName: "rainy"), currentTemp: 9, maxTemp: 17, minTemp: 7, saved: false, weatherCondition: "Rain", feelsLike: 12, humidity: 80, windSpeed: 2, visibility: 5 )
        let city5 = City(name: "Queensland", weatherImage: #imageLiteral(resourceName: "hurricane"), currentTemp: 5, maxTemp: 14, minTemp: 3, saved: false, weatherCondition: "Tornado", feelsLike: 12, humidity: 30, windSpeed: 15, visibility: 4)
        
        cities.append(city1)
        cities.append(city2)
        cities.append(city3)
        cities.append(city4)
        cities.append(city5)
        return cities
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
