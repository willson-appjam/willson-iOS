//
//  ChatListTableViewCell.swift
//  Willson
//
//  Created by JHKim on 05/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet var helperProfileImageView: UIImageView!
    @IBOutlet var helperNameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var alertImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
