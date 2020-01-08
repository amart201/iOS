//
//  EditContactViewController.swift
//  InClass09
//
//  Created by Aaron Martin on 11/20/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase

class EditContactViewController: UIViewController {
    
    var contact:Contact?
    var userID:String?
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.text = contact?.name
        emailTextField.text = contact?.email
        phoneNumberTextField.text = contact?.phoneNumber
        if contact?.phoneType == "Home" {
            phoneTypeSegmentControl.selectedSegmentIndex = 1
        } else if contact?.phoneType == "Office" {
            phoneTypeSegmentControl.selectedSegmentIndex = 2
        }
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeSegmentControl: UISegmentedControl!
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if nameTextField.text != "" {
            if emailTextField.text != "" {
                if phoneNumberTextField.text != "" {
                    ref.child(userID!).child((contact?.id)!).updateChildValues(["name" : self.nameTextField.text!, "email" : self.emailTextField.text!, "phone" : self.phoneNumberTextField.text!, "type": phoneTypeSegmentControl.titleForSegment(at: phoneTypeSegmentControl.selectedSegmentIndex)!])
                    self.navigationController?.popViewController(animated: true)
                } else {
                    alert(title: "Number Field Empty", message: "Need To Enter A Phone Number")
                }
            } else {
                alert(title: "Email Text Field Empty", message: "Need To Enter An Email Address")
            }
        } else {
            alert(title: "Name Field Empty", message: "Need To Enter A Name")
        }
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
