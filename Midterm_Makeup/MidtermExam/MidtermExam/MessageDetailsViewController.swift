//
//  MessageDetailsViewController.swift
//  MidtermExam
//
//  Created by Aaron Martin on 11/24/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire

class MessageDetailsViewController: UIViewController {
    
    @IBOutlet weak var threadNameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var thread:ThreadID?
    var message:Message?
    var user:User?
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        threadNameLabel.text = thread?.title
        creatorLabel.text = message?.createdBy
        messageLabel.text = message?.message
        
        if user?.id != message?.creatersID {
            navigationItem.rightBarButtonItem = nil
        } else if user?.id == message?.creatersID {
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let deleteMessageId = message!.id
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(user?.token ?? "")",
            "Accept": "application/json"
        ]
        let alert = UIAlertController(title: "Delete Message", message: "Are you sure you want to delete this Message?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/message/delete/\(deleteMessageId)",
                method: .get,
                parameters: nil,
                headers: headers).responseJSON { (response) in
                    if response.result.isSuccess {
                        print(response)
                        NotificationCenter.default.post(name: Notification.Name("reloadMessages"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}
