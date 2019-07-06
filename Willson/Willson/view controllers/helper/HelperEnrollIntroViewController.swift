//
//  HelperEnrollIntroViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperEnrollIntroViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var introText: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        introText.delegate = self
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumSquareB", size: 21.0)!];
        self.updateCharacterCount()
    }
    
    func updateCharacterCount() {
        let count = self.introText.text.count
        
        self.countLabel.text = "\((0) + count)/50자"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == introText){
            return textView.text.count +  (text.count - range.length) <= 50
        }
        return false
    }
}
