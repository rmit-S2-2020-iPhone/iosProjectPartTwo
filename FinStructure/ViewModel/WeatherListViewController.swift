//
//  WeatherListDisc.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 25/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WeatherManagerDelegate{
  
    

    @IBOutlet var table:UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var models:[CityModel] = []
    
    var dailyData: [CityModel.Daily] = []
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    @IBAction func addNoteBtn(_ sender: UIButton) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let tabBarController = appDelegate.window!.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 2
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        table.delegate = self
        table.dataSource=self
        
        //Ask user permission to use their location for privacy purposes
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(models)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        //let day = dailyData[indexPath.row]
        cell.dayLabel.text = dailyData[indexPath.row].daysInWeek
        cell.maxTempLabel.text = String(dailyData[indexPath.row].temp[0])
        cell.minTempLabel.text = String(dailyData[indexPath.row].temp[1])
        cell.weatherImage.image = UIImage(named: dailyData[indexPath.row].dailyImage)
        return cell
    }


    
    //WeatherManagerDelegate
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: CityModel) {
        DispatchQueue.main.sync {
            
            //append data to models for showing current weather
            models.append(weather)
            print(models)
          
            //append data to dailyData to show 7 days forecast weather
            dailyData = weather.daily
            table.reloadData()
        
        
            cityNameLabel.text = models[0].name
            currentTempLabel.text = "\(models[0].currentTemp)°C"
            minTempLabel.text = "\(models[0].minTemp)°C"
            maxTempLabel.text = "\(models[0].maxTemp)°C"
            weatherImage.image = UIImage(named: models[0].weatherCondition)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

// MARK: CLLLocationManagerDelegate

extension WeatherListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("Latitude: \(lat) - Longtitude: \(lon)")
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }

}
