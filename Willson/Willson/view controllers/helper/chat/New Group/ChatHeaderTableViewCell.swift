//
//  ChatHeaderTableViewCell.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ChatHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTitle: UILabel!
    
    @IBOutlet weak var notificationContent: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
