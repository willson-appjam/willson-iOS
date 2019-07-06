//
//  HelperEnrollExperienceViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperEnrollExperienceViewController: UIViewController,  UITextViewDelegate {

    @IBOutlet weak var experienceText: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    
    var isKeyboardAppear = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumSquareB", size: 21.0)!];
        
        experienceText.delegate = self
        
        tf1.borderStyle = .none
        tf2.borderStyle = .none
        tf3.borderStyle = .none
        self.updateCharacterCount()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateCharacterCount() {
        let count = self.experienceText.text.count
       
        self.countLabel.text = "\((0) + count)/220자"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == experienceText){
            return textView.text.count +  (text.count - range.length) <= 220
        }
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
            isKeyboardAppear = false
        }
    }
}

