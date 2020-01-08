//
//  DetailsContactViewController.swift
//  InClass09
//
//  Created by Aaron Martin on 11/20/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Firebase

class DetailsContactViewController: UIViewController {

    var contact:Contact?
    var userID:String?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref.child(userID!).child((contact?.id)!).observe(.value, with: {snapshot in
            if snapshot.hasChild("name") {
                if snapshot.childSnapshot(forPath: "name").value != nil && snapshot.childSnapshot(forPath: "email").value != nil && snapshot.childSnapshot(forPath: "phone").value != nil && snapshot.childSnapshot(forPath: "type").value != nil {
                    self.nameLabel.text = (snapshot.childSnapshot(forPath: "name").value as! String)
                    self.emailLabel.text = (snapshot.childSnapshot(forPath: "email").value as! String)
                    self.phoneNumberLabel.text = (snapshot.childSnapshot(forPath: "phone").value as! String)
                    self.phoneTypeLabel.text = (snapshot.childSnapshot(forPath: "type").value as! String)
                }
            }
        })
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneTypeLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue" {
            let destinationVC = segue.destination as! EditContactViewController
            destinationVC.contact = self.contact
            destinationVC.userID = self.userID
            destinationVC.ref = self.ref
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        ref.child(userID!).child((contact?.id)!).setValue(nil)
        self.navigationController?.popViewController(animated: true)
    }

}
