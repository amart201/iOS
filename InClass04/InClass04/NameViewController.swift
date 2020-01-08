//
//  NameViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.name != "" {
            newNameInput.text = name
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var newNameInput: UITextField!
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if self.newNameInput.text == "" || self.newNameInput.text == name{
            let alert = UIAlertController(title: "Field Not Updated", message: "Name Different From Current Name Should Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            NotificationCenter.default.post(name: Notification.Name("NameUpdate"), object: self.newNameInput.text)
            navigationController?.popViewController(animated: true)
        }
    }
    
    

}
