//
//  PasswordViewController.swift
//  InClass03
//
//  Created by Martin, Aaron on 9/16/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if password != "" {
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.PasswordTextField.text = hiddenPassword
        }
        // Do any additional setup after loading the view.
    }
    
    var password: String?
    var hiddenPassword = ""
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindPassword" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.password = PasswordTextField.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwindPassword" {
            if self.PasswordTextField.text == "" || self.PasswordTextField.text == password || self.PasswordTextField.text == hiddenPassword{
                let alert = UIAlertController(title: "Field Not Updated", message: "Password Different From Current Password Should Be Entered", preferredStyle: .alert)
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
