//
//  WeatherListDisc.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 25/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    // creation of data
    var datastores:[DataStore]=[]
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var addNoteLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Firing the data geneation method
        datastores=createArray()
        
        tableView.delegate = self
        tableView.dataSource=self
        addNoteLabel.text = "Add Notes"
        addNoteLabel.textColor = UIColor(red: (22.0/255.0), green: (64.0/255.0), blue: (22.0/255.0), alpha: 1.0)
        addNoteLabel.font = UIFont(name: "Marker Felt", size: 18)
        self.bgImage.addSubview(locationLabel)
        self.bgImage.addSubview(tempLabel)
        self.bgImage.addSubview(tempImage)
        self.bgImage.addSubview(addNoteLabel)
        DemoReq()
    }
    
    // Method that returns objects for corresponding data
    func createArray() -> [DataStore]
    {
        // Array That holds Objects
        var tempdatastores:[DataStore] = []
        
        // Creation of Objects
        let day1 = DataStore(dayofweek: "Monday", symbol: #imageLiteral(resourceName: "sunny-cloud"), maximumTempareture: "25°C" , minimumTempareture: "20°C" )
        let day2 = DataStore(dayofweek: "Tuesday", symbol: #imageLiteral(resourceName: "windy"), maximumTempareture: "22°C" , minimumTempareture: "19°C" )
        let day3 = DataStore(dayofweek: "Wednesday", symbol: #imageLiteral(resourceName: "thunder"), maximumTempareture: "23°C" , minimumTempareture: "13°C" )
        let day4 = DataStore(dayofweek: "Thursday", symbol: #imageLiteral(resourceName: "tabBar_1"), maximumTempareture: "21°C" , minimumTempareture: "15°C" )
        let day5 = DataStore(dayofweek: "Friday", symbol: #imageLiteral(resourceName: "sunny-cloud"), maximumTempareture: "19°C" , minimumTempareture: "17°C" )
        let day6 = DataStore(dayofweek: "Saturday", symbol: #imageLiteral(resourceName: "windy"), maximumTempareture: "20°C" , minimumTempareture: "18°C" )

        tempdatastores.append(day1)
        tempdatastores.append(day2)
        tempdatastores.append(day3)
        tempdatastores.append(day4)
        tempdatastores.append(day5)
        tempdatastores.append(day6)

        return tempdatastores
        
    }
    
    // Function for requesting data from API,To apply this, Application Trnasport Security Applied Explicitly
    func DemoReq()
    {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=-37.79746&lon=144.8717&exclude=hourly,daily&appid=54ba55c1be2e46294f88143ca6ca5eb9")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
           print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}

extension WeatherListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // count number of rows in table view
        return datastores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataall = datastores[indexPath.row]
        let cell=tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.setDataStore(data: dataall)
        return cell
    }
}
