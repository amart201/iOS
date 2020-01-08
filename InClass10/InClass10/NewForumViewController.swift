//
//  NewForumViewController.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Firebase

class NewForumViewController: UIViewController {
    
    @IBOutlet weak var newForumTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newForumTextView.layer.borderWidth = 1
        newForumTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if newForumTextView.text != "" {
            let userID = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            var userName:String?
            ref.child("User").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                userName = snapshot.childSnapshot(forPath: "name").value as? String
                ref.child("forums").childByAutoId().setValue(["name":userName, "message":self.newForumTextView.text, "creatorID":userID])
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
