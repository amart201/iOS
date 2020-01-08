//
//  SecondViewController.swift
//  Class04Prep
//
//  Created by Aaron Martin on 9/23/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if name != "" {
            secondViewLabel.text = name
        }
        // Do any additional setup after loading the view.
    }
     var name: String?

    @IBOutlet weak var newNameInput: UITextField!
    @IBOutlet weak var secondViewLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToFirstView" {
            let vc = segue.destination as! ViewController
            vc.newName = newNameInput.text
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
