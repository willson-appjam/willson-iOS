//
//  ChatHeaderTVC.swift
//  Willson
//
//  Created by 박지수 on 07/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ChatHeaderTVC: UITableViewHeaderFooterView {

    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationContent: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notificationTitle.sizeToFit()
        notificationContent.sizeToFit()
        timeStamp.sizeToFit()
    }
}
