//
//  SearchCityViewController.swift
//  FinStructure
//
//  Created by Louis An on 6/10/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    //array to store search result
    var searchArray:[CityModel] = []
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchCityInfoSegue" {
            let destVC = segue.destination as! CityInfoViewController
            destVC.city = sender as? CityModel
        }
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource
extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        let city = searchArray[indexPath.row]
        cell.setCity(city: city)
        return cell
    }
    
    //Pass data to CityInfoSegue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchArray[indexPath.row]
        performSegue(withIdentifier: "SearchCityInfoSegue", sender: city)
    }
    
    
    //Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.searchArray[indexPath.row].saved = false
                self.searchArray.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .right)
                tableView.endUpdates()
            }
            
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}


// MARK: UISearchBarDelegate, UITextFieldDelegate
extension SearchCityViewController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.endEditing(true)
            searchBar.text = ""
            cityTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let city = searchBar.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchBar.text = ""
        searchBar.endEditing(true)
        cityTableView.reloadData()
    }
}



// MARK: WeatherManagerDelegate
extension SearchCityViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: CityModel) {
        DispatchQueue.main.sync {
            searchArray.append(weather)
            cityTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        let alert = UIAlertController(title: "City Not Found", message: "Please search for another city.",         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

}
