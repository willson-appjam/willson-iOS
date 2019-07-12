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
    
    // MARK: - properties
    // Concern Question Post
    var categoryListIdx: Int = 0
    var feelingArray: [Int] = []
    
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
    
    @IBAction func tapped1Btn(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList4_DetailViewController") as? AskerList4_DetailViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = 1
    }
    
    @IBAction func tapped2Btn(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList4_DetailViewController") as? AskerList4_DetailViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = 2
    }
    
    @IBAction func tapped3Btn(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList4_DetailViewController") as? AskerList4_DetailViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = 3
    }
    
    @IBAction func tapped4Btn(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList4_DetailViewController") as? AskerList4_DetailViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = 4
    }
    
    @IBAction func tapped5Btn(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList4_DetailViewController") as? AskerList4_DetailViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = 5
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
