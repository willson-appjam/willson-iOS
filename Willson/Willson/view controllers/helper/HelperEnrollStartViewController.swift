//
//  HelperEnrollStartViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperEnrollStartViewController: UIViewController {

    @IBOutlet weak var startView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: 89))
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumSquareB", size: 21.0)!];
    }
}
