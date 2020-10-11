//
//  CityTableViewCell.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    // Connection With main Board

    @IBOutlet weak var cityTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherImageView: UIImageView!
    
    //Function to pass data from Main Method
    func setCity(city: CityModel){
        cityNameLabel.text = city.name.capitalized
        cityWeatherImageView.image = UIImage(named: city.weatherCondition)
        cityTempLabel.text = String(city.currentTemp) + "°C"
    }
}
