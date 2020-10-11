//
//  CityInfoViewController.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

//Setting up protocol to send weather data back to CityVC
//protocol SaveCityDelegate{
//    func saveCityToList(savedCity: CityModel)
//}

class CityInfoViewController: UIViewController {
    
    //top label for city weather condition in text eg: cloudy, sunny, rainy
    @IBOutlet weak var cityInfoWeatherCondition: UILabel!
    // image represents the current weather
    @IBOutlet weak var cityInfoWeatherImageView: UIImageView!
    
    //outlet for save button, it's used to hide the button after user clicked SAVED
    @IBOutlet weak var saveCityBtn: UIButton!
    
    // Weather details on the left side of the screen
    //Current temperature
    @IBOutlet weak var cityInfoTemp: UILabel!
    //Today high temp
    @IBOutlet weak var cityInfoHighTemp: UILabel!
    //Today low temp
    @IBOutlet weak var cityInfoLowTemp: UILabel!
    
    //Weather details on the right side of the screen
    @IBOutlet weak var cityDetailsFeelsLike: UILabel!
    @IBOutlet weak var cityDetailsHumidity: UILabel!
    @IBOutlet weak var cityDetailsWind: UILabel!
    @IBOutlet weak var cityDetailsVisibility: UILabel!
    
    var city: CityModel?
    
    var dayArray: [CityModel.Daily] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindToOneSegue" {
            let destVC = segue.destination as! CityViewController
            self.city?.saved = true
            destVC.city = self.city
        }
        
    }
    
    @IBAction func saveCityBtn(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToOneSegue", sender: self)
        print(city!.saved)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentCity = city {
            dayArray = currentCity.daily
        }
        print("CITY \(dayArray)")
        setUI()
        
    }
    
    //Passing the weather information to screen
    func setUI() {
        navigationItem.title = city?.name
        cityInfoWeatherCondition.text = city?.description
        cityInfoWeatherImageView.image = UIImage(named: city!.weatherCondition)
        
        cityInfoTemp.text = "\(city?.currentTemp ?? 0)°"
        cityInfoLowTemp.text = "\(city?.minTemp ?? 0)"
        cityInfoHighTemp.text = "\(city?.maxTemp ?? 0)"
        
        cityDetailsFeelsLike.text = "\(city?.feelsLike ?? 0)°C"
        cityDetailsHumidity.text = "\(city?.humidity ?? 0)%"
        cityDetailsWind.text = "\(city?.windSpeed ?? 0)km/h"
        cityDetailsVisibility.text = "\(city?.visibility ?? 0)km"
        
        if (city?.saved == true ){
            saveCityBtn.isEnabled = false
            saveCityBtn.imageView?.image = #imageLiteral(resourceName: "saveBtn-disabled")
        }
    }
}



// MARK: Prepare for unwind segue
extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityInfoCell", for: indexPath) as! CityInfoCell
        
        cell.dayLabel.text = dayArray[indexPath.row].daysInWeek
        cell.dayMaxTempLabel.text = String(dayArray[indexPath.row].temp[0])
        cell.dayMinTempLabel.text = String(dayArray[indexPath.row].temp[1])
        cell.dayWeatherImage.image = UIImage(named: dayArray[indexPath.row].dailyImage)
        return cell
    }
    
    
}



