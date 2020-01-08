//  Assignment #: HW03
//  File name: HW03.xcworkspace
//  Student Name: Aaron Martin
//
//  ViewController.swift
//  HW03
//
//  Created by Aaron Martin on 11/10/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cities = AppData.init().cities
    var countries = [String]()
    var city:String?
    var country:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countries.append(contentsOf: cities.keys)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let country = countries[section]
        return country
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let country = countries[section]
        return ((cities[country]?.count)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let country = countries[indexPath.section]
        let citiesInCountry = cities[country]
        
        let city = citiesInCountry![indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.country = countries[indexPath.section]
        let citiesInCountry = cities[country!]
        self.city = citiesInCountry![indexPath.row]
        self.performSegue(withIdentifier: "currentWeatherSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentWeatherSegue" {
            let destinationVC = segue.destination as! CurrentWeatherViewController
            destinationVC.city = self.city
            destinationVC.country = self.country
        }
    }

}

