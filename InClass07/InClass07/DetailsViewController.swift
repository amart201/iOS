//
//  DetailsViewController.swift
//  InClass07
//
//  Created by Aaron Martin on 10/31/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneTypeLabel: UILabel!
    
    var contact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = contact?.name
        emailLabel.text = contact?.email
        phoneNumberLabel.text = contact?.phoneNumber
        phoneTypeLabel.text = contact?.phoneType
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieveContactUpdateNotification(notification:)), name: Notification.Name("updateSelectedContact"), object: nil)
    }
    
    @objc func onRecieveContactUpdateNotification(notification: Notification){
        nameLabel.text = contact?.name
        emailLabel.text = contact?.email
        phoneNumberLabel.text = contact?.phoneNumber
        phoneTypeLabel.text = contact?.phoneType
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let parameters:Parameters = ["id": contact!.id!]
        Alamofire.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/delete", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            switch(response.result) {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("deleteSelectedContact"), object: nil)
                self.navigationController?.popViewController(animated: true)
            case .failure(_):
                print("error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destinationVC = segue.destination as! EditContactViewController
            destinationVC.contact = contact
        }
    }

}
