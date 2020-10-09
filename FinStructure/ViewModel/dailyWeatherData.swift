//
//  dailyWeatherData.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 20/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation
struct dailyWeatherData{
    let min:Double
    let max:Double
    
//    let dt:Double
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String,Any)
    }
    
    init (json:[String:Any]) throws {
        guard let min=json["min"] as? Double  else {throw SerializationError.missing("Minimum Tempareture is missing")}
       guard let max=json["max"] as? Double  else {throw SerializationError.missing("Maximum Tempareture is missing")}
//        guard let dt=json["dt"] as? Double  else {throw SerializationError.missing("Maximum Tempareture is missing")}
        
       self.min=min
       self.max=max
//        self.dt=dt
    }
    
    static func dailyforcast ( withLocation location:String ,completion: @escaping ([dailyWeatherData]) ->())
    {
        let url =  "https://api.openweathermap.org/data/2.5/onecall?lat=-37.79746&lon=144.8717&exclude=minutely&appid=54ba55c1be2e46294f88143ca6ca5eb9"
        
        let request = URLRequest(url: URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: request){ (data:Data?,response:URLResponse?,error:Error?) in
            
            var forecastArray:[dailyWeatherData]=[]
            if let data = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        if let dailyForecasts = json["daily"] as? [[String:Any]]{
//                            if let dailydata=dailyForecasts["temp"] as? [String:Any]{
//                                print(dailydata)
//
//                            }
                            
                            for d in dailyForecasts{
                                if let dailydata=d["temp"] as? [String:Any]
                                {
                                    if let weatherObject = try? dailyWeatherData(json: dailydata){
                                        forecastArray.append(weatherObject)
                                    }
                                }
//                                if let weatherObject = try? dailyWeatherData(json: d){
//                                    forecastArray.append(weatherObject)
//                                }
                            }
                            
//                            print (dailyForecasts)

                        }
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    
                }
                
                completion(forecastArray)
            }
            
            
        }
        task.resume()
    }
}
