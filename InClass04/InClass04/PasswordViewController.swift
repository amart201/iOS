//
//  PasswordViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    var password:String?
    var hiddenPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if password != "" {
            for _ in 1...password!.count {
                hiddenPassword.append("*")
            }
            self.newPasswordInput.text = hiddenPassword
        }
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var newPasswordInput: UITextField!
    
    @IBAction func updateButton(_ sender: Any) {
        if self.newPasswordInput.text == "" || self.newPasswordInput.text == password || self.newPasswordInput.text == hiddenPassword{
            let alert = UIAlertController(title: "Field Not Updated", message: "Password Different From Current Password Should Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        NotificationCenter.default.post(name: Notification.Name("PasswordUpdate"), object: self.newPasswordInput.text)
        navigationController?.popViewController(animated: true)
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
