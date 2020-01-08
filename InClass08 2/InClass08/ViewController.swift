//
//  ViewController.swift
//  InClass08
//
//  Created by Shehab, Mohamed on 11/11/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let parameters = [
            "q": "London,uk",
            "appid" : "c71031fd93a55887fa72637b11c986b2"
        ]
        
        let url = URL(string: "https://www.gannett-cdn.com/presto/2019/09/04/PASH/3086f052-e68f-4ced-8e3d-01ca21f38f4c-Screen_Shot_2019-09-03_at_8.45.04_PM.png?width=540&height=&fit=bounds&auto=webp")!
        self.imageView.af_setImage(withURL: url)
        //https://api.openweathermap.org/data/2.5/forecast?q=London,uk&appid=c71031fd93a55887fa72637b11c986b2
        
        //api.openweathermap.org/data/2.5/forecast
        //https://api.openweathermap.org/data/2.5/weather
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast", method: .get, parameters: parameters).responseJSON { (response) in
            
            let json = JSON(response.value!)
            print(json)
            
            let list = json["list"].arrayValue
            
            for item in list {
                let temp = item["main"]["temp"].stringValue
                let temp_min = item["main"]["temp_min"].stringValue
                let temp_max = item["main"]["temp_max"].stringValue
                print("\(temp), \(temp_min), \(temp_max)")
            }
            
            //print(json["dt"].stringValue)
            
            //print(json["main"]["humidity"].doubleValue)
            
            
        }
        
        
        //api.openweathermap.org/data/2.5/forecast?q=London,us&mode=xml

        
        
    }

    //https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=c71031fd93a55887fa72637b11c986b2


}

