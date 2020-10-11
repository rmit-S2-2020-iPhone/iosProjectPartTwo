//
//  CityViewController.swift
//  FinStructure
//
//  Created by Louis An on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class CityViewController: UIViewController{
    
    @IBOutlet weak var cityTableView: UITableView!

    //array of saved cities
    var savedCityArray:[CityModel] = []

    
    //Initialise weatherManager struct
    var weatherManager = WeatherManager()
    
    var city: CityModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Increase the font size of the NavigationBarTitle
       navigationController?.navigationBar.prefersLargeTitles = true
       navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //To check if a city is already existed in the array
        //If not, add it to the array and reload tableView
        //Avoid duplication of data from CityInfoViewController
        if let savedCity = city {
            let savedName = savedCity.name
            if savedCityArray.contains(where: { $0.name == savedName }) {
                return
            }
                savedCityArray.append(savedCity)
                self.cityTableView.reloadData()
        }
    }
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CityInfoSegue" {
            let destVC = segue.destination as! CityInfoViewController
            destVC.city = sender as? CityModel
        }
    }
    
    //Setting up unwind segue
    @IBAction func unwindToOne(_ sender: UIStoryboardSegue) {
    }
}



// MARK: UITableViewDelegate, UITableViewDataSource
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //set UITableViewCell to 150
        return 150
    }
    
    //set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return saved city array
        if savedCityArray.count == 0 {
            tableView.setEmptyMessage("Click on the 'Maginifying glass' to start searching for a city.")
        } else {
            tableView.restore()
        }
        
        return savedCityArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        let city = savedCityArray[indexPath.row]
        cell.setCity(city: city)
        return cell
    }
    
    
    //Pass data method
    //Seleft a city accordingly to the index of the row that user chooses
    //assign the details to a city
    //send city via segue to CityInfoViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let city = savedCityArray[indexPath.row]
            performSegue(withIdentifier: "CityInfoSegue", sender: city)
    }
    
    //Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                let alertController = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:
                {(action) in
                    self.savedCityArray[indexPath.row].saved = false
                    self.savedCityArray.remove(at: indexPath.row)
                    
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .right)
                    tableView.endUpdates()
                })
                
                alertController.addAction(deleteAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
        }
    }
}



//Setting up a view when there is no data in the CityViewController UITableView
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.1333333333, green: 0.3921568627, blue: 0.1333333333, alpha: 1)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "System", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
