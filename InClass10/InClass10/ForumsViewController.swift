//
//  ForumsViewController.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Firebase

class ForumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var forumsTableView: UITableView!
    var ref:DatabaseReference!
    var userID:String?
    var likeMessages = [String]()
    var forums = [Forum?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let forumCell = UINib(nibName: "ForumTableViewCell", bundle: nil)
        forumsTableView.register(forumCell, forCellReuseIdentifier: "forumCell")
        
        userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref.child("forums").observe(.value, with: {snapshot in
            self.forums.removeAll()
            for child in snapshot.children {
                let childSnap = child as! DataSnapshot
                let forum = Forum(id: childSnap.key, name: childSnap.childSnapshot(forPath: "name").value as! String, creatorID: childSnap.childSnapshot(forPath: "creatorID").value as! String, message: childSnap.childSnapshot(forPath: "message").value as! String, likes: Int(childSnap.childSnapshot(forPath: "likes").childrenCount))
                self.forums.append(forum)
            }
            self.forumsTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "forumSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forumSegue" {
            let VC = segue.destination as! ForumViewController
            VC.forum = forums[forumsTableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forumCell", for: indexPath) as! ForumTableViewCell
        
        cell.nameLabel.text = forums[indexPath.row]?.creatorName
        cell.messageLabel.text = forums[indexPath.row]?.message
        cell.likesLabel.text = "\((forums[indexPath.row]?.likes)?.description ?? "0") Likes"
        
        if userID != forums[indexPath.row]?.creatorID {
            cell.trashButton.isHidden = true
        } else {
            cell.trashButton.isHidden = false
        }
       
        
        cell.delegate = self
        
        return cell
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        AppDelegate.showLogin()
    }
    
}

extension ForumsViewController: CustomTVCellDelegate {
    func likeClicked(cell: UITableViewCell) {
        let indexPath = self.forumsTableView.indexPath(for: cell)
        ref.child("User").child(userID!).child("likedMessages").child(forums[indexPath!.row]!.id!).setValue(true)
        ref.child("forums").child(forums[(indexPath?.row)!]!.id!).child("likes").child(userID!).setValue(true)
        
    }
    
    func deleteClicked(cell: UITableViewCell) {
        let indexPath = self.forumsTableView.indexPath(for: cell)
        ref.child("forums").child(forums[(indexPath?.row)!]!.id!).setValue(nil)
    }
}
