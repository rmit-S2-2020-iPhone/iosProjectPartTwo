//
//  WeatherCell.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 25/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    // Connection with labels and views
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    // function for datahandler
    func setDataStore(data:DataStore)
    {
        dayName.text=data.dayofweek
        weatherImageView.image=data.symbol
        maxTemp.text=data.maximumTempareture
        minTemp.text=data.minimumTempareture
    }
}
