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

    @IBOutlet weak var cityInfoNameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityInfoWeatherImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBAction func saveCityBtn(_ sender: UIButton) {
        saveCity()
    }
    
    var city: City?
    
    var saveDelegate: SaveCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 18)
        setUI()
    }
    
    func setUI() {
        cityInfoNameLabel.text = city?.name
        weatherLabel.text = city?.weather
        cityInfoWeatherImageView.image = city?.weatherImage
        let temp = city?.maxTemp.description
        tempLabel.text = "TEMPATURE  " + temp! + "°C"
        let temp1 = city?.minTemp.description
        minTempLabel.text = "▼" + temp1! + "°C"
        maxTempLabel.text = "▲" + temp! + "°C"
    }
    
    @objc func saveCity() {
        saveDelegate?.saveCityToList(savedCity: city!)
        self.navigationController?.popViewController(animated: true)
    }
}
