//
//  FeelCollectionViewCell.swift
//  Willson
//
//  Created by JHKim on 05/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class FeelCollectionViewCell: UICollectionViewCell {

    @IBOutlet var feelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        feelLabel.sizeToFit()
    }

}
