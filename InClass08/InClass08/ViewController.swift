//  Assignment #: In Class 08
//  File Name: InClass08.xcworkspace
//  Student Name: Aaron Martin
//
//  ViewController.swift
//  InClass08
//
//  Created by Martin, Aaron on 11/4/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countries.append(contentsOf: cities.keys)
    }
    
    let cities = AppData.init().cities
    var countries = [String]()
    var weather:Weather?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let country = countries[section]
        return country
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = countries[indexPath.section]
        let citiesInCountry = cities[country]
        
        let city = citiesInCountry![indexPath.row]
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(city.replacingOccurrences(of: " ", with: "%20")),\(country)&units=imperial&APPID=24f284a029ac25f898f8bfd6c482c36a").responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                self.weather = Weather(country: country, city: city, json: data)
                self.performSegue(withIdentifier: "segue", sender: self)
            }
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destination = segue.destination as! WeatherDescriptionViewController
            destination.weather = self.weather
        }
    }
    

}

class Weather {
    var city:String?
    var country:String?
    var temp:String?
    var tempMax:String?
    var tempMin:String?
    var description:String?
    var humidity:String?
    var windSpeed:String?
    var windDegree:String?
    var cloudiness:String?
    init(country: String, city: String, json: JSON) {
        self.city = city
        self.country = country
        let weather = JSON(json["weather"]).arrayValue
        let weatherDescription = JSON(weather[0])
        self.description = weatherDescription["description"].stringValue
        let main = JSON(json["main"])
        self.temp = main["temp"].stringValue
        self.tempMin = main["temp_min"].stringValue
        self.tempMax = main["temp_max"].stringValue
        self.humidity = main["humidity"].stringValue
        let wind = JSON(json["wind"])
        self.windSpeed = wind["speed"].stringValue
        self.windDegree = wind["deg"].stringValue
        let clouds = JSON(json["clouds"])
        self.cloudiness = clouds["all"].stringValue
    }
}

