//  Assigment: Midterm Exam Makeup
//  File name: Midterm_Makeup
//  Student name: Aaron Martin
//   
//  LoginViewController.swift
//  MidtermExam
//
//  Created by Shehab, Mohamed on 11/22/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        AppDelegate.showSignUp()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        let parameters = ["email" : "\(email.text ?? "")", "password" : "\(password.text ?? "")"]
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/login", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                let status = data["status"].stringValue
                
                if status == "error" {
                    let message = data["message"].stringValue
                    let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else if status == "ok" {
                    print(response)
                    let user = User(token: data["token"].stringValue, email: data["user_email"].stringValue, firstName: data["user_fname"].stringValue, lastName: data["user_lname"].stringValue, id: data["user_id"].stringValue)
                    self.defaults.set(user.token, forKey: "token")
                    self.defaults.set(user.email, forKey: "email")
                    self.defaults.set(user.firstName, forKey: "fname")
                    self.defaults.set(user.lastName, forKey: "lname")
                    self.defaults.set(user.id, forKey: "id")
                    AppDelegate.showThreadsList()
                }
            } else if response.result.isFailure {
                print(response)
                let alert = UIAlertController.init(title: "Error", message: response.error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
 
    }
}
