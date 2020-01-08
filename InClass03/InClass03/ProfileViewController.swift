//
//  ProfileViewController.swift
//  InClass03
//
//  Created by Martin, Aaron on 9/16/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameOutput: UILabel!
    @IBOutlet weak var emailOutput: UILabel!
    @IBOutlet weak var passwordOutput: UILabel!
    @IBOutlet weak var departmentOutput: UILabel!
    @IBOutlet weak var passwordShowButton: UIButton!
    
    var name:String?
    var email:String?
    var password:String?
    var department:String?
    var departmentSelected:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUserContent()
        // Do any additional setup after loading the view.
    }
    
    func updateUserContent() {
        if name != "" {
            self.nameOutput.text = name
        }
        if email != "" {
            self.emailOutput.text = email
        }
        if password != "" {
            var hiddenPassword:String = ""
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.passwordOutput.text = hiddenPassword
        }
        if department != "" {
            self.departmentOutput.text = department
        }
    }
    
    @IBAction func passwordShow(_ sender: Any) {
        if self.passwordShowButton.currentTitle == "Show" {
            self.passwordOutput.text = password
            self.passwordShowButton.setTitle("Hide", for: .normal)
        } else if self.passwordShowButton.currentTitle == "Hide" {
            var hiddenPassword:String = ""
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.passwordOutput.text = hiddenPassword
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
            departmentVC.selectDepartment = departmentSelected
        }
    }
    
    @IBAction func unwindToProfile(_ unwindSegue: UIStoryboardSegue) {
        updateUserContent()
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func closeProfileView(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
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
