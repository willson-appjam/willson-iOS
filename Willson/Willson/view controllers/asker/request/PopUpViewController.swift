//
//  PopUpViewController.swift
//  Willson
//
//  Created by 박지수 on 02/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class PopUpViewController: PopUpVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        self.showAnimate()
    }
    
    @IBAction func removePopUpBtn(_ sender: Any) {
        //self.removeAnimate()
        self.showAnimate()
        let popOverVC = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier: "bPopUp2ID") as! PopUpViewController2
      
        super.addChild(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
}
