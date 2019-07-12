//
//  HelperCollectionViewCell.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperCollectionViewCell: UICollectionViewCell {

    @IBOutlet var category: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var detailInfo: UILabel!
    @IBOutlet var content: UITextView!
    @IBOutlet var tag1: UILabel!
    @IBOutlet var tag2: UILabel!
    @IBOutlet var tag3: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
