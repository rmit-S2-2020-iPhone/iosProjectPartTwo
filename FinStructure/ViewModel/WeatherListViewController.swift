//
//  WeatherListDisc.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 25/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    // creation of data

    
    @IBOutlet var table:UITableView!
    
    var models:[hourlyWeatherData] = []
//    var models2:[dailyWeatherData] = []
    
//    var json:WeatherResponse?
    
    let locationManager=CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dailyWeatherData.dailyforcast(withLocation: "re") { (resuls:[dailyWeatherData]) in
            for result in resuls{
                print("\(result)\n\n")
            }

        }
        
        dailyWeatherDetails.dailydatedetails(withLocation: "re") { (resuls:[dailyWeatherDetails]) in
            for result in resuls{
                print("\(result)\n\n")
            }
            
        }

        
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource=self
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setuplocation()
    }
    
    func setuplocation()
    {
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty,currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
           requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation()
    {
        guard let currentLocation = currentLocation else
        {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude

        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=-37.79746&lon=144.8717&exclude=minutely&appid=54ba55c1be2e46294f88143ca6ca5eb9"

       print ("\(long) | \(lat)")
        URLSession.shared.dataTask(with: URL(string: url)!,completionHandler:{data,response,error in
            guard let data = data,error == nil else {
                print("Something Went Wrong")
                return
            }


            var json:WeatherResponse?
            do{
                json = try JSONDecoder().decode(WeatherResponse.self,from: data)

            } catch{
                print ("error")

            }

            guard let result = json else {
                return
            }

   let entries = result.hourly
//            self.model.append(contentsOf:entries)

//            var flatted = result.hourly.flatMap{ $0 }
//             print(flatted[0])


        }).resume()
        
        
    }
    


    
//    func forecast(withLocation location:String,completion:@escaping ([dailyWeatherDate],[dailyWeatherData]) -> ())
//    {
//        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=-37.79746&lon=144.8717&exclude=minutely&appid=54ba55c1be2e46294f88143ca6ca5eb9"
//
//        let request = URLRequest(url:URL(string: url)!)
//
//        let task = URLSession.shared.dataTask(with: request) {(data:Data?,response:URLResponse?,error:Error?) in
//
//            var models123:[dailyWeatherDate] = []
//            var models234:[dailyWeatherData] = []
//
//            if let data = data{
//                do{
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
//                        if let dailyforcast = json["daily"] as? [String:Any]{
//                            if let dailydata = dailyforcast["temp"] as? [[String:Any]]{
//                                for datapoint in dailydata {
//                                    if let weatherobject = try? dailyWeatherData(json: datapoint){
//                                        models234.append(weatherobject)
//                                    }
//                                }
//                            }
//
//                        }
//
//                    }
//
//                }catch{
//                    print(error.localizedDescription)
//
//                }
//
//                completion(models123,models234)
//            }
//
//        }
//
//        task.resume()
//
//    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

}


struct WeatherResponse:Decodable{
    let lat:Double
    let lon:Double
    let timezone:String
    let timezone_offset:Double
    let current:currentWeather
    let hourly:[hourlyWeather]
//    let daily:[dailyWeather]
}
struct currentWeather:Codable{
    let dt:Double
    let sunrise:Double
    let sunset:Double
    let temp:Double
    let feels_like:Double
    let pressure:Double
    let humidity:Double
    let dew_point:Double
    let uvi:Double
    let clouds:Double
    let visibility:Double
    let wind_speed:Double
    let wind_deg:Double
    let weather:[WeatherData]
    
}

struct WeatherData:Codable{
    let id:Double
    let main:String
    let description:String
    let icon:String

}

struct hourlyWeather:Codable{
    
    let dt:Double

    let temp:Double

    let feels_like:Double

    let pressure:Double

    let humidity:Double

    let dew_point:Double

    let clouds:Double

    let visibility:Double

    let wind_speed:Double

    let wind_deg:Double

    let weather:[hourlyWeatherData]
    let pop:Double
    
}
struct hourlyWeatherData:Codable{
    let id:Double
    let main:String
    let description:String
    let icon:String
}

struct dailyWeather:Codable{
    
}


