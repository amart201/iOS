//
//  NewContactViewController.swift
//  HW02_Contacts
//
//  Created by Aaron Martin on 10/10/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var contact = Contact()
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var phoneNumberTextInput: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if nameTextInput.text == "" {
            let alert = UIAlertController(title: "Name Input Error", message: "Name Must Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if emailTextInput.text == "" {
            let alert = UIAlertController(title: "Email Input Error", message: "Email Must Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if Int(phoneNumberTextInput.text!) == nil || (phoneNumberTextInput.text?.count)! < 10 {
            let alert = UIAlertController(title: "Phone Number Error", message: "Phone Number Entered Must Be A Ten Digit Integer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            contact.name = nameTextInput.text
            contact.email = emailTextInput.text
            contact.phoneNumber = Int(phoneNumberTextInput.text!)
            contact.phoneTypeIndex = phoneTypeSegment.selectedSegmentIndex
            contact.phoneType = phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)
            
            NotificationCenter.default.post(name: Notification.Name("addNewContact"), object: contact)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
