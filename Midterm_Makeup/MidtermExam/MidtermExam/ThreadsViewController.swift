//
//  ThreadsViewController.swift
//  MidtermExam
//
//  Created by Shehab, Mohamed on 11/22/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ThreadsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var user:User?
    var threadIds = [ThreadID]()
    @IBOutlet weak var threadsTableView: UITableView!
    @IBOutlet weak var newThreadLabel: UITextField!
    let defaults = UserDefaults.standard
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ThreadTableViewCell", bundle: nil)
        threadsTableView.register(cellNib, forCellReuseIdentifier: "threadCell")
        user = User(token: defaults.string(forKey: "token")!, email: defaults.string(forKey: "email")!, firstName: defaults.string(forKey: "fname")!, lastName: defaults.string(forKey: "lname")!, id: defaults.string(forKey: "id")!)
        
        getThreads()
    }
    
    
    func getThreads() {
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(user!.token ?? "")",
            "Accept": "application/json"
        ]
        /*
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzQ0MTAxMDEsImV4cCI6MTYwNjAzMjUwMSwianRpIjoiNDNacmtzOHB2WHZQUlNVSkdaMkJPWiIsInVzZXIiOjJ9.xUf3PB3uOH8y5S48T1IT0hx_1rr64rp9NOI790exiE4"
        
        let exampleHeaders : HTTPHeaders = [
            "Authorization": "BEARER \(token)",
            "Accept": "application/json"
        ]
        */
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/threads",
                   method: .get,
                   parameters: nil,
                   headers: headers).responseJSON { (response) in
                    if response.result.isSuccess {
                        let data = JSON(response.result.value!)
                        let status = data["status"].stringValue
                        
                        if status == "ok" {
                            //print(response)
                            self.threadIds.removeAll()
                            let jsonThreads = data["threads"].arrayValue
                            for thread in jsonThreads {
                                let threadID = ThreadID(json: thread)
                                self.threadIds.append(threadID)
                            }
                            self.threadsTableView.reloadData()
                    }
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threadIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = threadsTableView.dequeueReusableCell(withIdentifier: "threadCell", for: indexPath) as! ThreadTableViewCell
        
        cell.threadTitle.text = threadIds[indexPath.row].title
        cell.createdByLabel.text = threadIds[indexPath.row].createdBy
        
        if threadIds[indexPath.row].creatersID != user!.id {
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "messagesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messagesSegue" {
            let destinationVC = segue.destination as! MessagesViewController
            destinationVC.threadId = threadIds[(threadsTableView.indexPathForSelectedRow?.row)!]
            destinationVC.user = self.user
        }
    }
    
    @IBAction func createNewThread(_ sender: Any) {
        if newThreadLabel.text != "" {
            let headers: HTTPHeaders = [
                "Authorization": "BEARER \(user!.token ?? "")",
                "Accept": "application/json"
            ]
            
            Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/thread/add",
                              method: .post,
                              parameters: ["title" : newThreadLabel.text!],
                              headers: headers).responseJSON { (response) in
                                if response.result.isSuccess {
                                    print(response)
                                    self.getThreads()
                                }
                                self.newThreadLabel.text = ""
            }
        }
    }
    
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        self.defaults.removeObject(forKey: "token")
        self.defaults.removeObject(forKey: "email")
        self.defaults.removeObject(forKey: "fname")
        self.defaults.removeObject(forKey: "lname")
        self.defaults.removeObject(forKey: "id")
        AppDelegate.showLogin()
    }
    

}

extension ThreadsViewController: CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell) {
        let indexPath = self.threadsTableView.indexPath(for: cell)
        let deleteThreadid = threadIds[(indexPath?.row)!].id
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(user!.token ?? "")",
            "Accept": "application/json"
        ]
        let alert = UIAlertController(title: "Delete Thread", message: "Are you sure you want to delete this thread?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/thread/delete/\(deleteThreadid)",
                method: .get,
                parameters: nil,
                headers: headers).responseJSON { (response) in
                    if response.result.isSuccess {
                        print(response)
                        self.getThreads()
                    }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

class ThreadID {
    var id:String
    var createdBy:String
    var title:String
    var creatersID:String
    init(json: JSON) {
        let create = json["created_by"]
        self.creatersID = create["user_id"].stringValue
        self.createdBy = "\(create["fname"].stringValue) \(create["lname"].stringValue)"
        self.id = json["thread_id"].stringValue
        self.title = json["title"].stringValue
    }
}
