//  Assignment # In Class 06
//  File Name: InClass06
//  Student Name: Aaron Martin
//
//  ViewController.swift
//  InClass06
//
//  Created by Martin, Aaron on 10/14/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userArray = DataInfo.users
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        let user = userArray[indexPath.row]
        
        if user.gender == "Female" {
            cell.userGender.image = UIImage(named: "avatar_female")
        } else if user.gender == "Male" {
            cell.userGender.image = UIImage(named: "avatar_male")
        }
        
        cell.userName.text = user.name
        cell.userState.text = user.state
        cell.userAge.text = "\(Int(user.age!)) Years Old"
        cell.userType.text = user.group
        
        return cell
    }
    
    @IBAction func sortButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Sort By", message: "Pick option to sort users by", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Name", style: .default, handler: { _ in
            self.userArray.sort(by: { $0.name! < $1.name!})
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Age", style: .default, handler: { _ in
            self.userArray.sort(by: { $0.age! < $1.age!})
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "State", style: .default, handler: { _ in
            self.userArray.sort(by: { $0.state! < $1.state!})
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func filterButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Filter By", message: "Pick option to filter users by", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gender: Female", style: .default, handler: { _ in
            self.userArray = DataInfo.users.filter{ $0.gender!.contains("Female")}
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Gender: Male", style: .default, handler: { _ in
            self.userArray = DataInfo.users.filter{ $0.gender!.contains("Male")}
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Show All", style: .default, handler: { _ in
            self.userArray = DataInfo.users
            self.usersTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var usersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        usersTableView.register(cellNib, forCellReuseIdentifier: "userCell")
        // Do any additional setup after loading the view, typically from a nib.
    }


}

