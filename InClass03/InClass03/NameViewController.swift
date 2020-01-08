//
//  NameViewController.swift
//  InClass03
//
//  Created by Martin, Aaron on 9/16/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.name != "" {
            updateNameInput.text = name
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var updateNameInput: UITextField!
    
    var name: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindName" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.name = updateNameInput.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwindName" {
            if self.updateNameInput.text == "" || self.updateNameInput.text == name{
                let alert = UIAlertController(title: "Field Not Updated", message: "Name Different From Current Name Should Be Entered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true){
            
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
