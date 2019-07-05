//
//  AskerList3_ImpactViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import DLRadioButton

class AskerList3_ImpactViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var radioButton_1: DLRadioButton!
    @IBOutlet weak var radioButton_2: DLRadioButton!
    @IBOutlet weak var radioButton_3: DLRadioButton!
    @IBOutlet weak var radioButton_4: DLRadioButton!
    @IBOutlet weak var radioButton_5: DLRadioButton!
    
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - life cycle
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
