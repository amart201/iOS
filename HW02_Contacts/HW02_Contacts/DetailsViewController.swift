//
//  DetailsViewController.swift
//  HW02_Contacts
//
//  Created by Aaron Martin on 10/9/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = selectedContact.name
        emailLabel.text = selectedContact.email
        phoneNumberLabel.text = String(selectedContact.phoneNumber!)
        phoneTypeLabel.text = selectedContact.phoneType
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactUpdateNotification(notification:)), name: Notification.Name("updateSelectedContact"), object: nil)
    }
    
    @objc func onRecieveContactUpdateNotification(notification: Notification) {
        selectedContact = notification.object as! Contact
        nameLabel.text = selectedContact.name
        emailLabel.text = selectedContact.email
        phoneNumberLabel.text = String(selectedContact.phoneNumber!)
        phoneTypeLabel.text = selectedContact.phoneType
    }
    
    var selectedContact = Contact()
    var numberOfSelectedContact:Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneTypeLabel: UILabel!
    
    
    @IBAction func detailsDeleteButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("deleteSelectedContact"), object: numberOfSelectedContact)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue" {
            let destinationVC = segue.destination as! EditContactViewController
            destinationVC.contactSelected = selectedContact
            destinationVC.numberOfContactSelected = numberOfSelectedContact
        }
    }
}
