//
//  ForecastViewController.swift
//  HW03
//
//  Created by Aaron Martin on 11/10/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var city:String?
    var country:String?
    var fiveDayForecast = [Forecast]()
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationLabel.text = "\(city ?? ""), \(country ?? "")"
        getInfo()
    }
    
    func getInfo() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=\(city?.replacingOccurrences(of: " ", with: "%20") ?? ""),\(country ?? "")&units=imperial&APPID=24f284a029ac25f898f8bfd6c482c36a").responseJSON(completionHandler: {(response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                let dailyForecast = JSON(data["list"]).arrayValue
                for cast in dailyForecast {
                    let forecast = Forecast(json: cast)
                    self.fiveDayForecast.append(forecast)
                }
                self.forecastTableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)
        
        let date = cell.viewWithTag(1) as! UILabel
        date.text = fiveDayForecast[indexPath.row].date
        let temp = cell.viewWithTag(2) as! UILabel
        temp.text = "\(fiveDayForecast[indexPath.row].temp ?? "")F"
        let maxTemp = cell.viewWithTag(3) as! UILabel
        maxTemp.text = "Max: \(fiveDayForecast[indexPath.row].tempMax ?? "")F"
        let minTemp = cell.viewWithTag(4) as! UILabel
        minTemp.text = "Min: \(fiveDayForecast[indexPath.row].tempMin ?? "")F"
        let humidity = cell.viewWithTag(5) as! UILabel
        humidity.text = "Humidity \(fiveDayForecast[indexPath.row].humidity ?? "")%"
        let descritption = cell.viewWithTag(6) as! UILabel
        descritption.text = fiveDayForecast[indexPath.row].description
        let imageIcon = cell.viewWithTag(7) as! UIImageView
        
        Alamofire.request("http://openweathermap.org/img/wn/\(fiveDayForecast[indexPath.row].imageCode ?? "")@2x.png").responseImage { response in
            if let image = response.result.value {
                imageIcon.image = image
            }
        }
        
        return cell
    }

}

class Forecast {
    var date:String?
    var temp:String?
    var tempMax:String?
    var tempMin:String?
    var humidity:String?
    var description:String?
    var imageCode:String?
    init(json: JSON) {
        let main = JSON(json["main"])
        self.temp = String(main["temp"].floatValue)
        self.tempMin = String(main["temp_min"].floatValue)
        self.tempMax = String(main["temp_max"].floatValue)
        self.humidity = main["humidity"].stringValue
        self.date = json["dt_txt"].stringValue
        let weather = JSON(json["weather"]).arrayValue
        let weatherDescription = JSON(weather[0])
        self.description = weatherDescription["description"].stringValue
        self.imageCode = weatherDescription["icon"].stringValue
    }
}
