//
//  CreateMessageViewController.swift
//  MidtermExam
//
//  Created by Aaron Martin on 11/24/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import Alamofire

class CreateMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var newMessageTextView: UITextView!
    var user:User?
    var thread:ThreadID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newMessageTextView.text = "Enter new message here."
        newMessageTextView.textColor = UIColor.lightGray
        newMessageTextView.layer.borderWidth = 1
        newMessageTextView.layer.borderColor = UIColor.lightGray.cgColor
        newMessageTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if newMessageTextView.textColor == UIColor.lightGray {
            newMessageTextView.text = ""
            newMessageTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if newMessageTextView.text.isEmpty {
            newMessageTextView.text = "Enter new message here."
            newMessageTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func submitNewMessage(_ sender: Any) {
        if newMessageTextView.text != "" || newMessageTextView.text != "Enter new message here."{
            let headers: HTTPHeaders = [
                "Authorization": "BEARER \(user?.token ?? "")",
                "Accept": "application/json"
            ]
            let parameters:Parameters = ["thread_id" : thread!.id, "message" : newMessageTextView.text!]
            
            Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/api/message/add",
                              method: .post,
                              parameters: parameters,
                              headers: headers).responseJSON { (response) in
                                if response.result.isSuccess {
                                    print(response)
                                    NotificationCenter.default.post(name: Notification.Name("reloadMessages"), object: nil)
                                    self.dismiss(animated: true, completion: nil)
                                }
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
