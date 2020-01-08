//
//  ContactsViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contacts = [Contact?]()
    var ref:DatabaseReference!
    var userID:String?
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let contactCell = UINib(nibName: "ContactTableViewCell", bundle: nil)
        tableView.register(contactCell, forCellReuseIdentifier: "contactCell")
        
        userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref.child(userID!).observe(.value, with: {snapshot in
            self.contacts.removeAll()
            for child in snapshot.children {
                let childSnap = child as! DataSnapshot
                let contact = Contact(id: childSnap.key , name: childSnap.childSnapshot(forPath: "name").value as! String, email: childSnap.childSnapshot(forPath: "email").value as! String, phoneNumber: childSnap.childSnapshot(forPath: "phone").value as! String, phoneType: childSnap.childSnapshot(forPath: "type").value as! String)
                self.contacts.append(contact)
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row]?.name
        cell.emailLabel.text = contacts[indexPath.row]?.email
        cell.phoneLabel.text = "\(contacts[indexPath.row]?.phoneNumber ?? "") (\(contacts[indexPath.row]?.phoneType ?? ""))"
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsContactSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsContactSegue" {
            let destinationVC = segue.destination as! DetailsContactViewController
            destinationVC.contact = contacts[(tableView.indexPathForSelectedRow?.row)!]
            destinationVC.userID = self.userID
            destinationVC.ref = self.ref
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        //logout user in firebase first
        //then go to the login screen
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        AppDelegate.showLogin()
    }
}

extension ContactsViewController: CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        ref.child(userID!).child(contacts[(indexPath?.row)!]!.id).setValue(nil)
    }
}

class Contact {
    var id:String
    var name:String
    var email:String
    var phoneNumber:String
    var phoneType:String
    
    init(id: String, name: String, email: String, phoneNumber: String, phoneType: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.phoneType = phoneType
    }
}
