//
//  HelperModeProfileViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperModeProfileViewController: UIViewController {
    
    // MARK: - properties
    
    // MARK: - IBOutlet

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func tappedCategoryEditButton(_ sender: Any) {
    }
    
    @IBAction func tappedProfileEditButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HelperSignUp", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HelperEnrollIntroViewController")
        self.navigationController?.show(viewController, sender: nil)
    }
    
    // MARK: - Methods
}
