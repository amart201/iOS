//
//  ViewController.swift
//  DemoCocoaPods
//
//  Created by Aaron Martin on 10/28/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func buttonClicked(_ sender: Any) {
        //HUD.flash(.success, delay: 2.0)
        HUD.flash(.labeledProgress(title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    

}

