//
//  UserTableViewCell.swift
//  InClass06
//
//  Created by Aaron Martin on 10/17/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var userGender: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userState: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userType: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
