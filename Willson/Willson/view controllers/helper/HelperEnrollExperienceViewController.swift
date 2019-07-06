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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumSquareB", size: 21.0)!];
        
        experienceText.delegate = self
        
        self.updateCharacterCount()
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
    

}

