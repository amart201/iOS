//
//  EmailViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    var email:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if email != "" {
            updateEmailInput.text = email
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var updateEmailInput: UITextField!
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if self.updateEmailInput.text == "" || self.updateEmailInput.text == email {
            let alert = UIAlertController(title: "Field Not Updated", message: "Email Different From Current Email Should Be Entered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        NotificationCenter.default.post(name: Notification.Name("EmailUpdate"), object: self.updateEmailInput.text)
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
