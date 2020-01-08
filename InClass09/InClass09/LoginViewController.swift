//
//  LoginViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        //login using Firebase
        //when done successfully
        //go to the Contacts View Controller.
        if emailTextField.text != "" {
            if passwordTextField.text != "" {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authResult, error) in
                        if error == nil {
                            AppDelegate.showContacts()
                    } else {
                        self.alert(title: "Sign Up Error", message: (error?.localizedDescription)!)
                    }
                }
            } else {
                alert(title: "No Password", message: "Need to Enter a Password")
            }
        } else {
            alert(title: "No Email", message: "Need to Enter Email")
        }
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        AppDelegate.showSignUp()
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
