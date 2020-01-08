//
//  ViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var DepartmentInput: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.name = self.nameInput.text
            profileVC.email = self.emailInput.text
            profileVC.password = self.passwordInput.text
            profileVC.department = self.DepartmentInput.titleForSegment(at: DepartmentInput.selectedSegmentIndex)
            profileVC.departmentSelected = self.DepartmentInput.selectedSegmentIndex
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "profileSegue" {
            if self.nameInput.text == "" {
                let alert = UIAlertController(title: "Missing Field", message: "Faild to Enter Name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else if self.emailInput.text == "" {
                let alert = UIAlertController(title: "Missing Field", message: "Faild to Enter Email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else if self.passwordInput.text == "" {
                let alert = UIAlertController(title: "Missing Field", message: "Faild to Enter Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        return true
    }
}

