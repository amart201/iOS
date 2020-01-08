//  Assignment# HW 02
//  File Name: HW02_Contacts.swift
//  Name: Aaron Martin
//
//  ViewController.swift
//  HW02_Contacts
//
//  Created by Aaron Martin on 10/6/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var contacts = [Contact]()
    var newContact = Contact()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contact1 = Contact()
        let contact2 = Contact()
        let contact3 = Contact()
        
        contact1.name = "Aaron Martin"
        contact1.email =  "amart201@uncc.edu"
        contact1.phoneNumber = 9103166653
        contact1.phoneType = "Cell"
        contact1.phoneTypeIndex = 0
        
        contact2.name = "Bob Smith"
        contact2.email = "bsmith@mail.com"
        contact2.phoneNumber = 1234567890
        contact2.phoneType = "Home"
        contact2.phoneTypeIndex = 1
        
        contact3.name = "Jane Doe"
        contact3.email = "janeD@mail.com"
        contact3.phoneNumber = 7023194019
        contact3.phoneType = "Office"
        contact3.phoneTypeIndex = 2
        
        contacts.append(contact1)
        contacts.append(contact2)
        contacts.append(contact3)
        
        // Do any additional setup after loading the view, typically from a nib.
        let cellNib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsTableView.register(cellNib, forCellReuseIdentifier: "contactCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveNewContactNotification(notification:)), name: Notification.Name("addNewContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactDeleteNotification(notification:)), name: Notification.Name("deleteSelectedContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactUpdateNotification(notification:)), name: Notification.Name("updateSelectedContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactListUpdateNotification(notification:)), name: Notification.Name("updateContactsList"), object: nil)
    }
    
    @objc func onRecieveNewContactNotification(notification: Notification){
        contacts.append(notification.object as! Contact)
        contactsTableView.reloadData()
    }
    
    @objc func onRecieveContactDeleteNotification(notification: Notification){
        contacts.remove(at: notification.object as! Int)
        contactsTableView.reloadData()
    }
    
    @objc func onRecieveContactUpdateNotification(notification: Notification){
        newContact = notification.object as! Contact
    }
    
    @objc func onRecieveContactListUpdateNotification(notification: Notification){
        contacts.remove(at: notification.object as! Int)
        contacts.insert(newContact, at: notification.object as! Int)
        contactsTableView.reloadData()
    }

    @IBOutlet weak var contactsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row].name
        cell.emailLabel.text = contacts[indexPath.row].email
        cell.phoneNumberLabel.text = String(contacts[indexPath.row].phoneNumber!)
        cell.phoneTypeLabel.text = "(\(contacts[indexPath.row].phoneType ?? "Home"))"
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedContact = contacts[(contactsTableView.indexPathForSelectedRow?.row)!]
            destinationVC.numberOfSelectedContact = contactsTableView.indexPathForSelectedRow?.row
        }
    }
    
}

class Contact {
    var name: String?
    var email: String?
    var phoneNumber: Int?
    var phoneType: String?
    var phoneTypeIndex: Int?
}

extension ViewController: CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell) {
        let indexPath = self.contactsTableView.indexPath(for: cell)
        contacts.remove(at: (indexPath?.row)!)
        contactsTableView.reloadData()
    }
}
