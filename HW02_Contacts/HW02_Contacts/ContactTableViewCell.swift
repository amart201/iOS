//
//  ContactTableViewCell.swift
//  HW02_Contacts
//
//  Created by Aaron Martin on 10/7/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

protocol CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell)
}

class ContactTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneTypeLabel: UILabel!
    var delegate: CustomTVCellDelegate?
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteButtonClicked(cell: self)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
