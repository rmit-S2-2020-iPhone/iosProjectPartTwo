//
//  WeatherManager.swift
//  FinStructure
//
//  Created by Louis An on 3/10/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: CityModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    //let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=54ba55c1be2e46294f88143ca6ca5eb9&units=metric"
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=54ba55c1be2e46294f88143ca6ca5eb9&units=metric&exclude=minutely,hourly,alerts"
    
    
    
    func fetchWeather(cityName: String){
        //Convert city name to coordinates
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let places = placemarks {
                if error == nil && places.count > 0 {
                    let place = places[0]
                    let lat = place.location!.coordinate.latitude
                    let lon = place.location!.coordinate.longitude
                    print(lat)
                    print(lon)
                   // let urlString = "\(self.weatherURL)&q=\(cityName)"
                    let urlString = "\(self.weatherURL)&lat=\(lat)&lon=\(lon)"
                    print(urlString)

                    self.performRequest(with: urlString, city: cityName)
                }
            }
        }
    }
    
    
    var delegate: WeatherManagerDelegate?
    
    
    func performRequest(with urlString: String, city: String){
        //1. Create a URL
        //string is option, use if let to safely unwrap it
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    //if there is an error, exit out of this function
                    return
                }
                if let safeData = data {
                    //Parse safeData in JSON to Swift object
                    if let weather = self.parseJSON(safeData, city: city) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data, city: String) -> CityModel?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CityData.self, from: weatherData)
            let id = decodeData.current.weather[0].id
            let description = decodeData.current.weather[0].description.capitalized
            let temp = decodeData.current.temp
            let feelsLike = decodeData.current.feels_like
            let humidity = decodeData.current.humidity
            let wind = decodeData.current.wind_speed
            let visibility = decodeData.current.visibility
            let max = decodeData.daily[0].temp.max
            let min = decodeData.daily[0].temp.min
            
            
            
            let weather = CityModel(name: city, description: description, conditionId: id, currentTemp: Int(temp), maxTemp: Int(max), minTemp: Int(min), saved: false, feelsLike: Int(feelsLike), humidity: humidity, windSpeed: Int(wind), visibility: visibility)
    
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
