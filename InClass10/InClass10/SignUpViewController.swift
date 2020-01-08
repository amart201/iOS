//
//  SignUpViewController.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if emailTextField.text != "" {
            if nameTextField.text != "" {
                if passwordTextField.text != "" {
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authResult, error) in
                        if error == nil {
                            let id = Auth.auth().currentUser?.uid
                            let ref = Database.database().reference()
                            ref.child("User").child(id!).setValue(["name":self.nameTextField.text])
                            AppDelegate.showForums()
                            
                        } else {
                            self.alert(title: "Sign Up Error", message: (error?.localizedDescription)!)
                        }
                    }
                }else {
                    alert(title: "No Password", message: "Need to enter a password!")
                }
            }else {
                alert(title: "No Name", message: "Need to enter your full name!")
            }
        }else {
            alert(title: "No Email", message: "Need to enter an email address!")
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        AppDelegate.showLogin()
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
