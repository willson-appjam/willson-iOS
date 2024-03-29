//
//  ReviewSlide.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ReviewSlide: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var asker: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 5
        
        
        category.sizeToFit()
        content.sizeToFit()
        asker.sizeToFit()
    }

}
