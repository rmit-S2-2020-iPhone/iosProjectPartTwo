//
//  CityViewController.swift
//  FinStructure
//
//  Created by Rakibul Hasan on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class CityViewController: UIViewController{

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    //initialise data Array
    var cityArray:[City] = []
    
    var searchCities:[City] = []
    var searchStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityArray = City.createArray()
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    //Set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchStatus == true {
            return searchCities.count
        }else {
            return cityArray.count
        }
    }
    
    //Populate date in a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        if searchStatus == true {
            let city = searchCities[indexPath.row]
            cell.setCity(city: city)
        } else {
            let city = cityArray[indexPath.row]
            cell.setCity(city: city)
        }
        return cell
    }
    
    // Pass data method
    // select a city accordingly to the index of the row that user click
    // asign the details to city
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityView = storyboard?.instantiateViewController(withIdentifier: "CityInfoViewController") as! CityInfoViewController
        cityView.city = cityArray[indexPath.row]
        cityView.saveDelegate = self
        self.navigationController?.pushViewController(cityView, animated: true)
    }
    
    //swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.cityArray.remove(at: indexPath.row)
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

//Search function
extension CityViewController: UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCities = cityArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searchStatus = true
        cityTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchStatus = false
        searchBar.endEditing(true)
        searchBar.text = ""
        cityTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchStatus = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchStatus = false
        searchBar.endEditing(true)
    }
}

//Data passed from CityInfoVC
extension CityViewController: SaveCityDelegate {
    
    func saveCityToList(savedCity: City) {
        cityArray.append(savedCity)
        cityTableView.reloadData()
    }
}
