//
//  HelperCollectionViewCell.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var reviewNum: UILabel!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        category.sizeToFit()
        name.sizeToFit()
        detailInfo.sizeToFit()
        reviewNum.sizeToFit()
    }
    
    @IBAction func viewProfileBtn(_ sender: Any) {
        /*let storyboard : UIStoryboard = UIStoryboard(name: "AskerRequest", bundle: Bundle.main)
        
        let uvc = storyboard.instantiateViewController(withIdentifier: "HelperProfileViewController")
       
        present(uvc!, animated: true, completion: nil)*/

    }

}
