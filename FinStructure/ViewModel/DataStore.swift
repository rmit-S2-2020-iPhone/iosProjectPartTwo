//
//  DataStore.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 25/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import UIKit
struct DataStore{
    
    // variable declaration
    var dayofweek:String?
    var symbol:UIImage?
    var maximumTempareture:String?
    var minimumTempareture:String?
    var latitude: Float?
    var longitude: Float?
    var timezone: String?
    var timezoneOfset: String?
    var current:CurrentTIme?
    var hourly:HourlyUpdate?
    var daily:DailyUpdate?

    // initial constructor to working for mock data
    init (dayofweek:String,symbol:UIImage,maximumTempareture:String,minimumTempareture:String)
    {
        self.dayofweek=dayofweek
        self.symbol=symbol
        self.maximumTempareture=maximumTempareture
        self.minimumTempareture=minimumTempareture
    }
    
    // constructor for working on API
    init (dayofweek:String,symbol:UIImage,maximumTempareture:String,minimumTempareture:String,latitude: Float,longitude: Float,timezone: String,timezoneOfset: String,Currenttime:String,Sunrisetime:String,Sunsettime:String,currenttemp:Float)
    {
        self.dayofweek=dayofweek
        self.symbol=symbol
        self.maximumTempareture=maximumTempareture
        self.minimumTempareture=minimumTempareture
        self.latitude=latitude
        self.longitude=longitude
        self.timezone=timezone
        self.timezoneOfset=timezoneOfset
    }
}

// Classes for subarray datasets
struct CurrentTIme:Codable
{
    var Currenttime:String?
    var Sunrisetime:String?
    var Sunsettime:String?
    var currenttemp:Float?
    var currentfeels_like:Float?
    var currentpressure:Float?
    var currenthumidity:Float?
    var currentdew_point:Float?
    var currentclouds:String?
    var currentuvi:String?
    var currentvisibility:String?
    var currentwind_speed:String?
    var currentwind_gust:String?
    var currentwind_deg:String?
    var currentweather:[WeatherDescription]
}

struct WeatherDescription:Codable
{
    var currentweatherid:String?
    var currentweathermain:String?
    var currentweatherdescription:String?
}

struct HourlyUpdate:Codable
{
    var hourlydt:String?
    var hourlytemp:String?
    var hourlyfeels_like:String?
    var hourlypressure:String?
    var hourlyhumidity:Float?
    var hourlylouds:String?
    var hourlyvisibility:String?
    var hourlyWeather:[HourlyWeather]
}

struct HourlyWeather:Codable
{
    var hourlyweathermain:String?
    var hourlyweatherdescription:String?
    var hourlyweatherid:String?
}

struct DailyUpdate:Codable
{
    var dailydt:String?
    var dailysunrise:String?
    var dailysunset:String?
    var dailytemp:[DailyData]
    var dailyfeels_like:String?
    var dailypressure:String?
}

struct DailyData:Codable
{
    var dailytempmorn:String?
    var dailytempday:String?
    var dailytempeve:String?
    var dailytempnight:String?
    var dailytempmin:Float?
    var dailytempmax:Float?
}
