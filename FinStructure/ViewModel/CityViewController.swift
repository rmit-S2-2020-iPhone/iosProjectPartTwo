//
//  CityViewController.swift
//  FinStructure
//
//  Created by Louis An on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class CityViewController: UIViewController{

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    //initialise data array
    //array consists of all Cities data
    var citiesArray:[City] = []
    
    //array of saved cities
    var savedCityArray:[City] = []
    
    //array of city that matches when searching
    var searchCities:[City] = []
    // status is false inititally, turns on when user starts searching for a city
    var searchStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Increase the font size of the NavigationBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        citiesArray = City.createArray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //there maybe multuple segue from a screen, this is to identify the correct segue
        if segue.identifier == "CityInfoSegue" {
            //set destination to the correct ViewControllerΩ
            let destVC = segue.destination as! CityInfoViewController
            destVC.city = sender as? City
            destVC.saveDelegate = self
        }
    }
}



// MARK: UITableViewDelegate, UITableViewDataSource

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchStatus == true {
            return searchCities.count
        }else {
            //return saved city array
            return savedCityArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        if searchStatus == true {
            let city = searchCities[indexPath.row]
            cell.setCity(city: city)
        }else {
            let city = savedCityArray[indexPath.row]
            cell.setCity(city: city)
        }
        return cell
    }
    
    //Pass data method
    //Seleft a city accordingly to the index of the row that user chooses
    //assign the details to a city
    //send city via segue to CityInfoViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchStatus == true {
            let city = searchCities[indexPath.row]
            performSegue(withIdentifier: "CityInfoSegue", sender: city)
        } else {
            let city = savedCityArray[indexPath.row]
            performSegue(withIdentifier: "CityInfoSegue", sender: city)
        }
    }
    
    //Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if searchStatus == false {
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
}


// MARK: UISearchBArDelegate, UITextFieldDelegate

extension CityViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //click 'x' button on searchBar will show savedCity array rather than the whole citiesArray
        if searchText.isEmpty {
            searchStatus = false
            searchBar.endEditing(true)
            searchBar.text = ""
            cityTableView.reloadData()
        }else {
            searchCities = citiesArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
            searchStatus = true
            cityTableView.reloadData()
        }
       
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchStatus = false
        //resignFirstResponder to release focus on searchbar and hide keyboard
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchStatus = false
        searchBar.text = ""
        searchBar.endEditing(true)
        cityTableView.reloadData()
    }
}



// MARK: SaveCityDelegate
extension CityViewController: SaveCityDelegate {
    func saveCityToList(savedCity: City) {
        savedCityArray.append(savedCity)
        cityTableView.reloadData()
    }
}


