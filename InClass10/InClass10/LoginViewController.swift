//
//  LoginViewController.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if emailTextField.text != "" {
            if passwordTextField.text != "" {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authResult, error) in
                        if error == nil {
                            AppDelegate.showForums()
                    } else {
                        self.alert(title: "Login Error", message: (error?.localizedDescription)!)
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
