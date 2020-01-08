//
//  ForumViewController.swift
//  InClass10
//
//  Created by Aaron Martin on 12/4/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Firebase

class ForumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    var forum:Forum?
    var messages = [Message]()
    var ref:DatabaseReference!
    var userID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authorLabel.text = forum?.creatorName
        messageLabel.text = forum?.message
        likesLabel.text = "\(forum?.likes?.description ?? "") Likes"
        
        let commentCell = UINib(nibName: "CommentTableViewCell", bundle: nil)
        messagesTableView.register(commentCell, forCellReuseIdentifier: "commentCell")
        
        userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref.child("forums").child(forum!.id!).child("comments").observe(.value, with: {snapshot in
            self.messages.removeAll()
            for child in snapshot.children {
                let childSnap = child as! DataSnapshot
                let message = Message(messageID: childSnap.key, autherID: childSnap.childSnapshot(forPath: "authorID").value as! String, autherName: childSnap.childSnapshot(forPath: "authorName").value as! String, message: childSnap.childSnapshot(forPath: "comment").value as! String)
                self.messages.append(message)
            }
            self.messagesTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
         
        cell.nameLabel.text = messages[indexPath.row].autherName
        cell.commentLabel.text = messages[indexPath.row].message
         
        if userID != messages[indexPath.row].autherID {
            cell.trashCanButton.isHidden = true
         } else {
             cell.trashCanButton.isHidden = false
         }
        
         
         cell.delegate = self
         
         return cell
    }
    
    @IBAction func submitComment(_ sender: Any) {
        if commentTextField.text != "" {
            let userID = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            var userName:String?
            ref.child("User").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                userName = snapshot.childSnapshot(forPath: "name").value as? String
                ref.child("forums").child(self.forum!.id!).child("comments").childByAutoId().setValue(["authorName":userName, "comment":self.commentTextField.text, "authorID":userID])
            })
            
        }
    }
    

}

extension ForumViewController: CommentTVCellDelegate {
    func deleteButton(cell: UITableViewCell) {
        let indexPath = self.messagesTableView.indexPath(for: cell)
        ref.child("forums").child(forum!.id!).child("comments").child(messages[indexPath!.row].id!).setValue(nil)
    }
}
