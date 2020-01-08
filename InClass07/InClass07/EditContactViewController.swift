//
//  EditContactViewController.swift
//  InClass07
//
//  Created by Aaron Martin on 10/31/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire

class EditContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    var contact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.text = contact?.name
        emailTextField.text = contact?.email
        phoneNumberTextField.text = contact?.phoneNumber
        
        if contact?.phoneType == "CELL" {
            phoneTypeSegment.selectedSegmentIndex = 0
        } else if contact?.phoneType == "HOME" {
            phoneTypeSegment.selectedSegmentIndex = 1
        } else if contact?.phoneType == "OFFICE" {
            phoneTypeSegment.selectedSegmentIndex = 2
        }
        
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
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
            contact?.name = nameTextField.text
            contact?.email = emailTextField.text
            contact?.phoneNumber = phoneNumberTextField.text
            contact?.phoneType = phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)
            
            let parameters:Parameters = ["id" : contact!.id!, "name" : nameTextField.text!, "email" : emailTextField.text!, "phone" : phoneNumberTextField.text!, "type" : phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)!]
            
            Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/update", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
                switch(response.result) {
                case .success(_):
                    NotificationCenter.default.post(name: Notification.Name("updateSelectedContact"), object: self.contact)
                    self.navigationController?.popViewController(animated: true)
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    

}
