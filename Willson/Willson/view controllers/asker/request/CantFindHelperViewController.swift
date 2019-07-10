//
//  CantFindHelperViewController.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class CantFindHelperViewController: UIViewController {
    
    // MARK: - properties
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func tappedSearchOneMore(_ sender: Any) {
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
    }
    
}
