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
    
    @IBOutlet weak var pickerTextField: UITextField!
   
    @IBOutlet weak var nextBtn: UIButton!
    
    let salutations = ["20세", "21세","22세","23세","24세","25세","26세","27세","28세","29세","30세","31세","32세","33세","34세","35세","36세"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let pickerView = UIPickerView()
        pickerView.delegate = self
        
    
        pickerTextField.inputView = pickerView
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "AskerSignUpViewController2") as! AskerSignUpViewController2
        
        self.present(dvc, animated: true)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
