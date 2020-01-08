//
//  NewContactViewController.swift
//  InClass07
//
//  Created by Aaron Martin on 10/31/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire

class NewContactViewController: UIViewController {

    var contact:Contact?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
            if nameTextField.text == "" {
                let alert = UIAlertController(title: "Name Input Error", message: "Name Must Be Entered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if emailTextField.text == "" {
                let alert = UIAlertController(title: "Email Input Error", message: "Email Must Be Entered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if phoneNumberTextField.text == "" {
                let alert = UIAlertController(title: "Phone Number Error", message: "Phone Number Entered Must Be A Ten Digit Integer", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                
                let parameters:Parameters = ["name" : nameTextField.text!, "email" : emailTextField.text!, "phone" : phoneNumberTextField.text!, "type" : phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)!]
                
                Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/create", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
                    switch(response.result) {
                    case .success(_):
                        NotificationCenter.default.post(name: Notification.Name("addNewContact"), object: nil)
                        self.dismiss(animated: true, completion: nil)
                    case .failure(_):
                        print("error")
                    }
                }
            }
    }
    
}
