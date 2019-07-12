//
//  AskerList7_HelperExperienceViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList7_HelperExperienceViewController: UIViewController {
    
    // MARK: - properties
    // Concern Question Post
    var categoryListIdx: Int = 0
    var feelingArray: [Int] = []
    var weight: Int = 0
    var content: String = ""
    var gender: String = ""
    var personalityArray: [Int] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!

    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
    }

    // MARK: - Navigation
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "7To8" {
            guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList8_ChatDirectionViewController") as? AskerList8_ChatDirectionViewController else { return }
            vc.categoryListIdx = self.categoryListIdx
            vc.feelingArray = self.feelingArray
            vc.weight = self.weight
            vc.content = self.content
            vc.gender = self.gender
            vc.personalityArray = self.personalityArray
            vc.experienceArray.append(textField1.text ?? "")
            vc.experienceArray.append(textField2.text ?? "")
            vc.experienceArray.append(textField3.text ?? "")
        }
    }
}
