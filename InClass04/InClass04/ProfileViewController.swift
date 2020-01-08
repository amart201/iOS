//
//  ProfileViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var name:String?
    var email:String?
    var password:String?
    var department:String?
    var departmentSelected: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var passwordShowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveNameNotification(notification:)), name: Notification.Name("NameUpdate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveEmailNotification(notification:)), name: Notification.Name("EmailUpdate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecievePasswordNotification(notification:)), name: Notification.Name("PasswordUpdate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveDepartmentNotification(notification:)), name: Notification.Name("DepartmentUpdate"), object: nil)
        
        if name != nil {
            self.nameLabel.text = name
        }
        if email != nil {
            self.emailLabel.text = email
        }
        if password != nil {
            var hiddenPassword:String = ""
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.passwordLabel.text = hiddenPassword
        }
        if department != nil {
            self.departmentLabel.text = department
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func onRecieveNameNotification(notification: Notification) {
        name = (notification.object as! String)
        nameLabel.text = name
    }
    
    @objc func onRecieveEmailNotification(notification: Notification) {
        email = (notification.object as! String)
        emailLabel.text = email
    }
    
    @objc func onRecievePasswordNotification(notification: Notification) {
        password = (notification.object as! String)
        var hiddenPassword:String = ""
        for _ in 1...password!.count {
            hiddenPassword.append("*")
        }
        self.passwordLabel.text = hiddenPassword
    }
    
    @objc func onRecieveDepartmentNotification(notification: Notification) {
        department = (notification.object as! String)
        departmentLabel.text = department
    }
    
    @IBAction func showPassword(_ sender: Any) {
        if self.passwordShowButton.currentTitle == "Show" {
            self.passwordLabel.text = password
            self.passwordShowButton.setTitle("Hide", for: .normal)
        } else if self.passwordShowButton.currentTitle == "Hide" {
            var hiddenPassword:String = ""
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.passwordLabel.text = hiddenPassword
            self.passwordShowButton.setTitle("Show", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NameViewController" {
            let nameVC = segue.destination as! NameViewController
            nameVC.name = name
        } else if segue.identifier == "EmailViewController" {
            let emailVC = segue.destination as! EmailViewController
            emailVC.email = email
        } else if segue.identifier == "PasswordViewController" {
            let passwordVC = segue.destination as! PasswordViewController
            passwordVC.password = password
        } else if segue.identifier == "DepartmentViewController" {
            let departmentVC = segue.destination as! DepartmentViewController
            departmentVC.selectedDepartment = departmentSelected
        }
    }

}
