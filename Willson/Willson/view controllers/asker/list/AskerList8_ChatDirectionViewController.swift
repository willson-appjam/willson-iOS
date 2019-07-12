//
//  AskerList8_ChatDirectionViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList8_ChatDirectionViewController: UIViewController {
    
    // MARK: - properties
    // Concern Question Post
    var categoryListIdx: Int = 0
    var feelingArray: [Int] = []
    var weight: Int = 0
    var content: String = ""
    var gender: String = ""
    var personalityArray: [Int] = []
    var experienceArray: [String] = []

    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapped1emotion(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.emotion = 1
    }
    
    @IBAction func tapped2emotion(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.emotion = 2
    }
    
    @IBAction func tapped3emotion(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.emotion = 3
    }
    
    @IBAction func tapped4emotion(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.emotion = 4
    }
    
    @IBAction func tapped5emotion(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.emotion = 5
    }
    
    @IBAction func tapped1advice(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.advise = 1
    }
    
    @IBAction func tapped2advice(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.advise = 2
    }
    
    @IBAction func tapped3advice(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.advise = 3
    }
    
    @IBAction func tapped4advice(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.advise = 4
    }
    
    @IBAction func tapped5advice(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.advise = 5
    }
    
    @IBAction func tapped1experience(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.experience = 1
    }
    
    @IBAction func tapped2experience(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.experience = 2
    }
    
    @IBAction func tapped3experience(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.experience = 3
    }
    
    @IBAction func tapped4experience(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.experience = 4
    }
    
    @IBAction func tapped5experience(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
        vc.categoryListIdx = self.categoryListIdx
        vc.feelingArray = self.feelingArray
        vc.weight = self.weight
        vc.content = self.content
        vc.gender = self.gender
        vc.personalityArray = self.personalityArray
        vc.experienceArray = self.experienceArray
        vc.experience = 5
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "8To9" {
            guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList9_AgreementViewController") as? AskerList9_AgreementViewController else { return }
            vc.categoryListIdx = self.categoryListIdx
            vc.feelingArray = self.feelingArray
            vc.weight = self.weight
            vc.content = self.content
            vc.gender = self.gender
            vc.personalityArray = self.personalityArray
            vc.experienceArray = self.experienceArray
            
        }
    }

}
