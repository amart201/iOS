//
//  CommentTableViewCell.swift
//  InClass10
//
//  Created by Aaron Martin on 12/4/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

protocol CommentTVCellDelegate {
    func deleteButton(cell: UITableViewCell)
}

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var trashCanButton: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    var delegate:CommentTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.deleteButton(cell: self)
    }
    
    
}
