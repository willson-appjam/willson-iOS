//
//  ReviewStarViewController.swift
//  Willson
//
//  Created by JHKim on 05/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ReviewStarViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var selectStarLabel: UILabel!
    @IBOutlet weak var StarCommentLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func tappedCheckButton(_ sender: Any) {
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
