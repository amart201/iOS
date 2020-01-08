//
//  ContactTableViewCell.swift
//  InClass07
//
//  Created by Aaron Martin on 10/31/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

protocol CustomTVCellDelegate {
    func deleteClicked(cell: UITableViewCell)
}

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberAndTypeLabel: UILabel!
    var delegate: CustomTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        delegate?.deleteClicked(cell: self)
    }
    
    
}
