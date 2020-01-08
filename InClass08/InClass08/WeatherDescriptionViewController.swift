//
//  WeatherDescriptionViewController.swift
//  InClass08
//
//  Created by Martin, Aaron on 11/4/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class WeatherDescriptionViewController: UIViewController {
    
    var weather:Weather?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationLabel.text = "\(weather?.city ?? ""), \(weather?.country ?? "")"
        tempLabel.text = "\(weather?.temp ?? "") F"
        tempMaxLabel.text = "\(weather?.tempMax ?? "") F"
        tempMinLabel.text = "\(weather?.tempMin ?? "") F"
        descriptionLabel.text = weather?.description
        humidityLabel.text = "\(weather?.humidity ?? "")%"
        windSpeedLabel.text = "\(weather?.windSpeed ?? "") miles/hr"
        windDegreeLabel.text = "\(weather?.windDegree ?? "") degrees"
        cloudinessLabel.text = "\(weather?.cloudiness ?? "")%"
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    
}
