//
//  AskerNoRequestViewController.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerNoRequestViewController: UIViewController {
    
    // MARK: - IBOutlet

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - IBAction
    @IBAction func tappedGoToHome(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerTabbar", bundle: nil).instantiateViewController(withIdentifier: "AskerTabbar") as? UITabBarController else { return }
        self.present(vc, animated: true)
    }
}
