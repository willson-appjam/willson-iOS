//
//  AskerSNSSignUpViewController.swift
//  Willson
//
//  Created by 박지수 on 02/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerSNSSignUpViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!
    
    var snsEmail = ""
    let salutations = ["20세", "21세","22세","23세","24세","25세","26세","27세","28세","29세","30세","31세","32세","33세","34세","35세","36세"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.text = self.snsEmail
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerTextField.inputView = pickerView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return salutations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = salutations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return salutations[row]
    }
}
