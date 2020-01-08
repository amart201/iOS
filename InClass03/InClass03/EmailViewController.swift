//
//  EmailViewController.swift
//  InClass03
//
//  Created by Martin, Aaron on 9/16/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if email != "" {
            emailTextField.text = email
        }
        // Do any additional setup after loading the view.
    }
    
    var email: String?

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindEmail" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.email = emailTextField.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwindEmail" {
            if self.emailTextField.text == "" || self.emailTextField.text == email{
                let alert = UIAlertController(title: "Field Not Updated", message: "Email Different From Current Email Should Be Entered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        return true
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
