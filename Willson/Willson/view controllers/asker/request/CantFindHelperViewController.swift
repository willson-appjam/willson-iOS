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
        let tabbarStoryboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        guard let tabBarController: UITabBarController = tabbarStoryboard.instantiateViewController(withIdentifier: "AskerTabbar") as? UITabBarController else { return }
        tabBarController.selectedIndex = 1
        
        let requestStoryboard = UIStoryboard(name: "AskerRequest", bundle: nil)
        guard let vc: AskerRequestViewController = requestStoryboard.instantiateViewController(withIdentifier: "AskerRequestViewController") as? AskerRequestViewController else { return }
        vc.extended = true
        self.present(tabBarController, animated: true)
        
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
