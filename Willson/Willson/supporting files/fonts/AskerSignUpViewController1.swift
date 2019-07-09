//
//  AskerSignUpViewController1.swift
//  Willson
//
//  Created by 박지수 on 30/06/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import DLRadioButton

class AskerSignUpViewController1: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordTF2: UITextField!
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var wSex: DLRadioButton!
    @IBOutlet weak var mSex: DLRadioButton!
    @IBOutlet weak var agreeChk: UIButton!
    
    
    // MARK: - properties
    let salutations = ["20세", "21세","22세","23세","24세","25세","26세","27세","28세","29세","30세","31세","32세","33세","34세","35세","36세"]
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        
        pickerTextField.inputView = pickerView
        
        //빈화면 탭했을 때 제스처 추가
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - IBAction
    @IBAction func agreeChkAction(_ sender: Any) {
        if agreeChk.isSelected == true {
            nextBtn.isEnabled = false
            agreeChk.isEnabled = false
        } else {
            nextBtn.isSelected = true
            agreeChk.isEnabled = true
        }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        guard let dvc: AskerSignUpViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "AskerSignUpViewController2") as? AskerSignUpViewController2 else { return }
        
        self.present(dvc, animated: true)
    }
    
    
    
    // MARK: - Methods
    
    //빈 화면 탭했을 때 키보드 내리기
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
    
    func changeBtnColor(button: UIButton) {
        button.isSelected = !button.isSelected
        
        if (button.isSelected)
        {
            button.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
        }
            
        else
        {
            button.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)
        }
    }
}
