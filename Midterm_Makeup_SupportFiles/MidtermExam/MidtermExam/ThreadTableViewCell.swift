//
//  ThreadTableViewCell.swift
//  MidtermExam
//
//  Created by Aaron Martin on 11/24/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit

protocol CustomTVCellDelegate {
    func deleteButtonClicked(cell: UITableViewCell)
}

class ThreadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var threadTitle: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var delegate: CustomTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteButtonClicked(cell: self)
    }
    
    
}
