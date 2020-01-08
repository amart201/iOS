//
//  ContactTableViewCell.swift
//  InClass09
//
//  Created by Aaron Martin on 11/22/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell)
}

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var delegate: CustomTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteButtonClicked(cell: self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
