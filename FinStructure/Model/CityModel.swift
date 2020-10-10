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
    let timeStamp: Int
    let daily: [Daily]
    
    
    //Daily to store daily forecast weatherData
    struct Daily {
        let day: Int
        let temp: [Int]
        var daysInWeek: String {
            let unixtimeInterval = TimeInterval(day)
            let date = Date(timeIntervalSince1970: unixtimeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "EEEE" //Specify your format that you want
            let strDate: String = dateFormatter.string(from: date)
            return strDate
        }
        let dailyImageId: Int
        
        var dailyImage: String {
            switch dailyImageId {
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
    
    var day: String {
        let unixtimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE" //Specify your format that you want
        let strDate: String = dateFormatter.string(from: date)
        return strDate
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
