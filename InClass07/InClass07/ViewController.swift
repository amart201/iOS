//
//  ViewController.swift
//  InClass07
//
//  Created by Aaron Martin on 10/31/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contacts = [Contact]()
    @IBOutlet weak var contactsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getInfo()
        
        let contactCell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsTableView.register(contactCell, forCellReuseIdentifier: "contactCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveNewContactNotification(notification:)), name: Notification.Name("addNewContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactDeleteNotification(notification:)), name: Notification.Name("deleteSelectedContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactUpdateNotification(notification:)), name: Notification.Name("updateSelectedContact"), object: nil)
    }
    
    @objc func onRecieveNewContactNotification(notification: Notification){
        getInfo()
    }
    
    @objc func onRecieveContactDeleteNotification(notification: Notification){
        getInfo()
    }
    
    @objc func onRecieveContactUpdateNotification(notification: Notification){
        getInfo()
    }
    
    func getInfo() {
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contacts", method: .get).responseString { (response) in
            switch(response.result) {
            case .success(_):
                self.parseString(stringOfContacts: response.value!)
            case .failure(_):
                print("error")
            }
        }
    }
    
    func parseString(stringOfContacts: String) {
        contacts.removeAll()
        let contactsStrings = stringOfContacts.split(separator: "\n")
        for contact in contactsStrings {
            var newContact = contact.split(separator: ",")
            contacts.append(Contact(id: String(newContact[0]), name: String(newContact[1]), email: String(newContact[2]), phoneNumber: String(newContact[3]), phoneType: String(newContact[4])))
        }
        contactsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row].name
        cell.emailLabel.text = contacts[indexPath.row].email
        cell.numberAndTypeLabel.text = "\(contacts[indexPath.row].phoneNumber!)(\(contacts[indexPath.row].phoneType!))"
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.contact = contacts[(contactsTableView.indexPathForSelectedRow?.row)!]
        }
    }
}

class Contact {
    var id:String?
    var name:String?
    var email:String?
    var phoneNumber:String?
    var phoneType:String?
    init(id: String, name: String, email: String, phoneNumber: String, phoneType: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
    }
}

extension ViewController: CustomTVCellDelegate {
    func deleteClicked(cell: UITableViewCell) {
        let indexPath = self.contactsTableView.indexPath(for: cell)
        let parameters:Parameters = ["id": contacts[(indexPath?.row)!].id!]
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/delete", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            switch(response.result) {
            case .success(_):
                self.getInfo()
            case .failure(_):
                print("error")
            }
        }
    }
}
