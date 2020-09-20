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
    var weather: String
    var weatherImage: UIImage
    var maxTemp: Int
    var minTemp: Int
    
    init(name: String, weather: String, weatherImage: UIImage, maxTemp: Int, minTemp: Int) {
        self.name = name
        self.weather = weather
        self.weatherImage = weatherImage
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
    
    //Add data into array
     class func createArray() -> [City]{
        var cities: [City] = []
        
        let city1 = City(name: "Melbourne", weather: "Windy", weatherImage: #imageLiteral(resourceName: "windy"), maxTemp: 20, minTemp: 10 )
        let city2 = City(name: "Sydney", weather: "Cloudy", weatherImage: #imageLiteral(resourceName: "sunny-cloud"), maxTemp: 25, minTemp: 10 )
        let city3 = City(name: "Perth", weather: "Thunder", weatherImage: #imageLiteral(resourceName: "thunder"), maxTemp: 12, minTemp: 8 )
        let city4 = City(name: "Canberra", weather: "Thunder", weatherImage: #imageLiteral(resourceName: "thunder"), maxTemp: 17, minTemp: 7 )
        let city5 = City(name: "Queensland", weather: "Thunder", weatherImage: #imageLiteral(resourceName: "thunder"), maxTemp: 14, minTemp: 3 )
        
        cities.append(city1)
        cities.append(city2)
        cities.append(city3)
        cities.append(city4)
        cities.append(city5)
        return cities
    }
}
