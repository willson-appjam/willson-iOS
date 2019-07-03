//
//  HelperReviewCollectionViewCell.swift
//  Willson
//
//  Created by 박지수 on 03/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var starReview: UIStackView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var name: UILabel!
    
    /*let listNameLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 고민자들의 후기"
        label.textColor = UIColor(red: 44/255, green: 44/255, blue: 77/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        category.sizeToFit()
        name.sizeToFit()
        date.sizeToFit()
        content.sizeToFit()
        starReview.sizeToFit()
        
      
    }

}
