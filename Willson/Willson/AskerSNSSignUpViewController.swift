//
//  AskerSNSSignUpViewController.swift
//  Willson
//
//  Created by 박지수 on 02/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerSNSSignUpViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var age: UITextField!
    var snsEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.text = self.snsEmail
    }
}
