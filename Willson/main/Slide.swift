//
//  Slide.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /*category.layer.borderWidth = 1.0
        category.layer.borderColor = UIColor(red:82/255, green:82/255, blue:161/255, alpha: 1).cgColor*/
        
        name.sizeToFit()
        category.sizeToFit()
        content.sizeToFit()
    }
}
