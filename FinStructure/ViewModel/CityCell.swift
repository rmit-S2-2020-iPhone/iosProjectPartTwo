//
//  CityTableViewCell.swift
//  FinStructure
//
//  Created by Louis An on 22/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherImageView: UIImageView!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    func setCity(city: City){
        cityNameLabel.text = city.name
        cityWeatherImageView.image = city.weatherImage
        cityTempLabel.text = String(city.maxTemp.description) + "°C"
    }
}
