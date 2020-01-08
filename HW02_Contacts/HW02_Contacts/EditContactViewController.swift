//
//  EditContactViewController.swift
//  HW02_Contacts
//
//  Created by Aaron Martin on 10/9/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.text = contactSelected.name
        emailTextField.text = contactSelected.email
        phoneNumberTextField.text = String(contactSelected.phoneNumber!)
        phoneTypeSegment.setEnabled(true, forSegmentAt: contactSelected.phoneTypeIndex!)
    }
    
    var contactSelected = Contact()
    var numberOfContactSelected:Int?
    var phoneTypeIndex:Int?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Name Input Error", message: "Name Must Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if emailTextField.text == "" {
            let alert = UIAlertController(title: "Email Input Error", message: "Email Must Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if Int(phoneNumberTextField.text!) == nil || (phoneNumberTextField.text?.count)! < 10 {
            let alert = UIAlertController(title: "Phone Number Error", message: "Phone Number Entered Must Be A Ten Digit Integer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            contactSelected.name = nameTextField.text
            contactSelected.email = emailTextField.text
            contactSelected.phoneNumber = Int(phoneNumberTextField.text!)
            contactSelected.phoneTypeIndex = phoneTypeSegment.selectedSegmentIndex
            contactSelected.phoneType = phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)
            
            NotificationCenter.default.post(name: Notification.Name("updateSelectedContact"), object: contactSelected)
            NotificationCenter.default.post(name: Notification.Name("updateContactsList"), object: numberOfContactSelected)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
