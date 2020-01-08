//
//  MessagesViewController.swift
//  MidtermExam
//
//  Created by Aaron Martin on 11/24/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var threadNameLabel: UILabel!
    @IBOutlet weak var messagesTableView: UITableView!
    var user:User?
    var threadId:ThreadID?
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ThreadTableViewCell", bundle: nil)
        messagesTableView.register(cellNib, forCellReuseIdentifier: "threadCell")

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onReloadMessagesNotification(notification:)), name: Notification.Name("reloadMessages"), object: nil)
        threadNameLabel.text = threadId?.title
        getMessages()
    }
    
    @objc func onReloadMessagesNotification(notification: Notification){
        getMessages()
    }
    
    func getMessages() {
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(user?.token ?? "")",
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/messages/\(threadId?.id ?? "")",
                          method: .get,
                          parameters: nil,
                          headers: headers).responseJSON { (response) in
                            if response.result.isSuccess {
                                let data = JSON(response.result.value!)
                                let status = data["status"].stringValue
                                if status == "ok" {
                                    
                                    self.messages.removeAll()
                                    let jsonMessages = data["messages"].arrayValue
                                    for nextMessage in jsonMessages {
                                        let message = Message(json: nextMessage)
                                        self.messages.append(message)
                                    }
                                    self.messagesTableView.reloadData()
                                }
                            } else if response.result.isFailure {
                                print(response.error?.localizedDescription as Any)
                            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "threadCell", for: indexPath) as! ThreadTableViewCell
        
        cell.threadTitle.text = messages[indexPath.row].createdBy
        cell.createdByLabel.text = messages[indexPath.row].message
        if messages[indexPath.row].creatersID != user?.id {
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "messageDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetailsSegue" {
            let destinationVC = segue.destination as! MessageDetailsViewController
            destinationVC.message = messages[(messagesTableView.indexPathForSelectedRow?.row)!]
            destinationVC.user = self.user
        } else if segue.identifier == "createMessageSegue" {
            let destinationVC = segue.destination as! CreateMessageViewController
            destinationVC.user = self.user
            destinationVC.thread = self.threadId
        }
    }
    
}

extension MessagesViewController: CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell) {
        let indexPath = self.messagesTableView.indexPath(for: cell)
        let deleteMessageId = messages[(indexPath?.row)!].id
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
                        self.getMessages()
                    }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

class Message {
    var id:String
    var createdBy:String
    var message:String
    var creatersID:String
    init(json: JSON) {
        let create = json["created_by"]
        self.creatersID = create["user_id"].stringValue
        self.createdBy = "\(create["fname"].stringValue) \(create["lname"].stringValue)"
        self.id = json["message_id"].stringValue
        self.message = json["message"].stringValue
    }
}
