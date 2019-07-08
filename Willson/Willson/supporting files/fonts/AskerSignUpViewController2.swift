//
//  AskerSignUpViewController2.swift
//  Willson
//
//  Created by 박지수 on 30/06/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerSignUpViewController2: UIViewController {
    
    // MARK: - properties
    
    // MARK: - IBOutlet

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func tappedStartWillsonBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerTabbar")
        self.present(viewController, animated: true)
    }
    
    // MARK: Methods

}
