//
//  dailyWeatherDetails.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 23/9/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import Foundation

struct dailyWeatherDetails{
    let dt:Int
    
    enum SerializationError:Error{
        case missing(String)
        case invalid(String,Any)
    }
    
    init (json:[String:Any]) throws {

               guard let dt=json["dt"] as? Int  else {throw SerializationError.missing("Maximum Tempareture is missing")}
               self.dt=dt
    }
    
    
    static func dailydatedetails ( withLocation location:String ,completion: @escaping ([dailyWeatherDetails]) ->())
    {
        let url =  "https://api.openweathermap.org/data/2.5/onecall?lat=-37.79746&lon=144.8717&exclude=minutely&appid=54ba55c1be2e46294f88143ca6ca5eb9"
        
        let request = URLRequest(url: URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: request){ (data:Data?,response:URLResponse?,error:Error?) in
            
            var dateDetailsArray:[dailyWeatherDetails]=[]
            if let data = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        if let dailyForecasts = json["daily"] as? [[String:Any]]{
                        
                            for d in dailyForecasts{
 
                                if let weatherObject = try? dailyWeatherDetails(json: d){
                        dateDetailsArray.append(weatherObject)
                                            }
                            }
                            
                            
                        }
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    
                }
                
                completion(dateDetailsArray)
            }
            
            
        }
        task.resume()
    }
}
