//
//  ProblemDetailTitleTableViewCell.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ProblemDetailTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var category: UIView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var personality1: UILabel!
    @IBOutlet weak var personality2: UILabel!
    @IBOutlet weak var personality3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        category.sizeToFit()
        personality1.sizeToFit()
        personality2.sizeToFit()
        personality3.sizeToFit()
    }
    
}
