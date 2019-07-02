//
//  HelperProfileViewController.swift
//  Willson
//
//  Created by 박지수 on 02/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class HelperProfileViewController: UIViewController {
   
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var startBtn: MDCFloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        //startBtn.applyOutlinedTheme(withScheme: containerScheme)
        
        /*let backImg: UIImage = UIImage(named: "btnBackbtn")!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, for: [], barMetrics: .default)*/
        
    }
    
    
    func setNavigationBar() {
        self.navigationItem.title = "헬퍼 프로필"
        //self.setBackBtn(color: UIColor.black)
        self.setNavigationBarShadow()
    }
}
