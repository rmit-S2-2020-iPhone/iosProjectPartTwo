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
    
    
    //fetch weather in SearchCityViewController
    //input is city name
    func fetchWeather(cityName: String){
        //Convert city name to coordinates
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let places = placemarks {
                if error == nil && places.count > 0 {
                    let place = places[0]
                    let lat = place.location!.coordinate.latitude
                    let lon = place.location!.coordinate.longitude
                    
                    let urlString = "\(self.weatherURL)&lat=\(lat)&lon=\(lon)"
                    //TEST result
                    //print(lat)
                    //print(lon)
                   // print(urlString)

                    self.performRequest(with: urlString, city: cityName)
                }
            } else {
                self.delegate?.didFailWithError(error: error!)
            }
        }
    }
    
    //fetch weather for WeatherListViewController
    //inputs are users' current location
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        //Convert coordinates to city name
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) {(placemarks, error) in
            if let places = placemarks {
                if error == nil && places.count > 0 {
                    let place = places [0]
                    let cityName = place.locality ?? "unknown"
                    print (cityName)
                    let urlString = "\(self.weatherURL)&lat=\(latitude)&lon=\(longitude)"
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
            let today = decodeData.current.dt
        
            
            
            var daily: [CityModel.Daily] = []
            for item in 0..<(decodeData.daily.count - 1) {
                var array: [Int] = []
                //loop through each Daily data
                array.append(Int(decodeData.daily[item].temp.max))
                array.append(Int(decodeData.daily[item].temp.min))
                //Assign Array to CityModel.Daily Array
                let dailyArray = CityModel.Daily(day: decodeData.daily[item].dt, temp: array, dailyImageId: decodeData.daily[item].weather[0].id)
                //get total DailyData Array
                daily.append(dailyArray)
            }
            
          
            let weather = CityModel(name: city, description: description, conditionId: id, currentTemp: Int(temp), maxTemp: Int(max), minTemp: Int(min), saved: false, feelsLike: Int(feelsLike), humidity: humidity, windSpeed: Int(wind), visibility: visibility, timeStamp: today, daily: daily)
            
            
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
