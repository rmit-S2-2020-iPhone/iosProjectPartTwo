//
//  CityInfoViewController.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

//Setting up protocol to send weather data back to CityVC
protocol SaveCityDelegate{
    func saveCityToList(savedCity: City)
}

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
    
    @IBAction func saveCityBtn(_ sender: Any) {
        saveCity()
        self.navigationController?.popViewController(animated: true)
    }
    
    var city: City?
    
    var saveDelegate: SaveCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //Passing the weather information to screen
    func setUI() {
        navigationItem.title = city?.name
        cityInfoWeatherCondition.text = city?.weatherCondition
        cityInfoWeatherImageView.image = city?.weatherImage
        
        cityInfoTemp.text = "\(city?.currentTemp ?? 0)°"
        cityInfoLowTemp.text = "\(city?.minTemp ?? 0)"
        cityInfoHighTemp.text = "\(city?.maxTemp ?? 0)"
        
        cityDetailsFeelsLike.text = "\(city?.feelsLike ?? 0)°C"
        cityDetailsHumidity.text = "\(city?.humidity ?? 0)%"
        cityDetailsWind.text = "\(city?.windSpeed ?? 0)km/h"
        cityDetailsVisibility.text = "\(city?.visibility ?? 0)km"
        
        if (city?.saved == true ){
            saveCityBtn.isHidden = true
        }
    }
    
    func saveCity() {
        city?.saved = true
        saveDelegate?.saveCityToList(savedCity: city!)
    }
}
