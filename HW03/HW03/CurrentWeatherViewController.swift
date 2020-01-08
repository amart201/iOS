//
//  CurrentWeatherViewController.swift
//  HW03
//
//  Created by Aaron Martin on 11/10/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class CurrentWeatherViewController: UIViewController {

    var city:String?
    var country:String?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getInfo()
    }
    
    func getInfo() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(city!.replacingOccurrences(of: " ", with: "%20")),\(country ?? "")&units=imperial&APPID=24f284a029ac25f898f8bfd6c482c36a").responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                let weather = Weather(country: self.country!, city: self.city!, json: data)
                self.locationLabel.text = "\(weather.city ?? ""), \(weather.country ?? "")"
                self.tempLabel.text = "\(weather.temp ?? "") F"
                self.tempMaxLabel.text = "\(weather.tempMax ?? "") F"
                self.tempMinLabel.text = "\(weather.tempMin ?? "") F"
                self.descriptionLabel.text = weather.description
                self.humidityLabel.text = "\(weather.humidity ?? "")%"
                self.windSpeedLabel.text = "\(weather.windSpeed ?? "") miles/hr"
                self.windDegreeLabel.text = "\(weather.windDegree ?? "") degrees"
                self.cloudinessLabel.text = "\(weather.cloudiness ?? "")%"
                Alamofire.request("http://openweathermap.org/img/wn/\(weather.imageIcon ?? "")@2x.png").responseImage { response in
                    if let image = response.result.value {
                        self.icon.image = image
                    }
                }
            }
        })
    }
    
    
    @IBAction func forecastClicked(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forecastSegue" {
            let destination = segue.destination as! ForecastViewController
            destination.city = self.city
            destination.country = self.country
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
    var imageIcon:String?
    
    init(country: String, city: String, json: JSON) {
        self.city = city
        self.country = country
        let weather = JSON(json["weather"]).arrayValue
        let weatherDescription = JSON(weather[0])
        self.description = weatherDescription["description"].stringValue
        self.imageIcon = weatherDescription["icon"].stringValue
        let main = JSON(json["main"])
        self.temp = String(main["temp"].floatValue)
        self.tempMin = String(main["temp_min"].floatValue)
        self.tempMax = String(main["temp_max"].floatValue)
        self.humidity = main["humidity"].stringValue
        let wind = JSON(json["wind"])
        self.windSpeed = wind["speed"].stringValue
        self.windDegree = wind["deg"].stringValue
        let clouds = JSON(json["clouds"])
        self.cloudiness = clouds["all"].stringValue
    }
}
