//
//  CompleteRequestViewController.swift
//  Willson
//
//  Created by JHKim on 08/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class CompleteRequestViewController: UIViewController {
    
    // MARK: - properties

    // MARK: - IBOutlet
    @IBOutlet weak var fireworksImageView: UIImageView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fireworksImageView.image = UIImage.gif(asset: "fireworks")
        
    }
    
    // MARK: - IBAction
    
    // MARK: - Methods

}
