//
//  FeelCollectionViewCell.swift
//  Willson
//
//  Created by JHKim on 05/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class FeelCollectionViewCell: UICollectionViewCell {

    @IBOutlet var view: CustonView!
    @IBOutlet var feelLabel: UILabel!
    var tabCount: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        view.sizeToFit()
        feelLabel.sizeToFit()
        tabCount = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.isSelected = !self.isSelected
        
        if (self.isSelected)
        {
            view.backgroundColor =  #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            feelLabel.textColor = UIColor.white
        }
        else
        {
            view.backgroundColor = UIColor.white
            feelLabel.textColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
        }
    }
}
