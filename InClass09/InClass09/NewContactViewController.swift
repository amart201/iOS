//
//  NewContactViewController.swift
//  InClass09
//
//  Created by Aaron Martin on 11/20/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneTypeSegment: UISegmentedControl!
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if nameTextField.text != "" {
            if emailTextField.text != "" {
                if phoneNumberTextField.text != "" {
                    let userID = Auth.auth().currentUser?.uid
                    let ref = Database.database().reference()
                    ref.child(userID!).childByAutoId().setValue(["name" : self.nameTextField.text, "email" : self.emailTextField.text, "phone" : self.phoneNumberTextField.text, "type": phoneTypeSegment.titleForSegment(at: phoneTypeSegment.selectedSegmentIndex)])
                    self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
