//
//  ChatHeaderTVC.swift
//  Willson
//
//  Created by 박지수 on 07/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ChatHeaderTVC: UITableViewHeaderFooterView {

    static let reuseIdentifier: String = String(describing: self)
   
    
    @IBOutlet var notificationTitle: UILabel!
    @IBOutlet var notificationContent: UILabel!
    @IBOutlet var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notificationTitle.sizeToFit()
        notificationContent.sizeToFit()
        timeStamp.sizeToFit()
    }
}
