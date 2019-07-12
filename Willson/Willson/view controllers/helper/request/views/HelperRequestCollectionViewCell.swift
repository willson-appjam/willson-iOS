//
//  HelperRequestCollectionViewCell.swift
//  Willson
//
//  Created by JHKim on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperRequestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timer: UIView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var content: UILabel!
    var userID: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
