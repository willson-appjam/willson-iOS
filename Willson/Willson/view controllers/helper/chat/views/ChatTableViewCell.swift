//
//  ChatTableViewCell.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var oppoText: UILabel!
    @IBOutlet weak var ownText: UILabel!
    
    @IBOutlet weak var oppoTime: UILabel!
    @IBOutlet weak var ownTime: UILabel!
    @IBOutlet weak var oppoView: CustonView!
    @IBOutlet weak var ownView: CustonView!
    
    let userId = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        oppoText.sizeToFit()
        ownText.sizeToFit()
        oppoTime.sizeToFit()
        ownTime.sizeToFit()
        
        oppoText.translatesAutoresizingMaskIntoConstraints = false
        oppoView.translatesAutoresizingMaskIntoConstraints = false
        ownText.translatesAutoresizingMaskIntoConstraints = false
        ownView.translatesAutoresizingMaskIntoConstraints = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
