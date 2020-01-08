//
//  ForumTableViewCell.swift
//  InClass10
//
//  Created by Aaron Martin on 11/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

protocol CustomTVCellDelegate {
    func deleteClicked(cell: UITableViewCell)
    func likeClicked(cell: UITableViewCell)
}

class ForumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    var delegate:CustomTVCellDelegate?
    
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
    
    @IBAction func likeClicked(_ sender: Any) {
        delegate?.likeClicked(cell: self)
    }
    
}
