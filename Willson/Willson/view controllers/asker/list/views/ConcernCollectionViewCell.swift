//
//  ConcernCollectionViewCell.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ConcernCollectionViewCell: UICollectionViewCell {

    @IBOutlet var concernLabel: UILabel!
    @IBOutlet var concernTextField: UITextField!
    @IBOutlet weak var view: CustonView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        concernLabel.sizeToFit()
        concernTextField.sizeToFit()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)

    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.isSelected = false
        
        self.concernTextField.text = ""
        
        if (self.isSelected) {
            view.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            concernLabel.textColor = UIColor.white
        } else {
            view.backgroundColor = UIColor.white
            concernLabel.textColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
        }
    }
}

