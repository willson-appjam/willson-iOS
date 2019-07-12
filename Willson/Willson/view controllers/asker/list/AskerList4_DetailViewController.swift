//
//  AskerList4_DetailViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList4_DetailViewController: UIViewController {

    // MARK: - properties
    // Concern Question Post
    var categoryListIdx: Int = 0
    var feelingArray: [Int] = []
    var weight: Int = 0
    
    // MARK: - IBOutlet
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //글자 수 카운트
        detailText.delegate = self
        self.updateCharacterCount()
        
        //화면 탭하면 키보드 사라짐
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
    }
    

    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "4To5" {
            guard let vc = UIStoryboard(name: "AskerList", bundle: nil).instantiateViewController(withIdentifier: "AskerList5_HelperSexViewController") as? AskerList5_HelperSexViewController else { return }
            vc.categoryListIdx = self.categoryListIdx
            vc.feelingArray = self.feelingArray
            vc.weight = self.weight
            vc.content = self.detailText.text
        }
    }
    
}

extension AskerList4_DetailViewController: UITextViewDelegate {
    
    func updateCharacterCount() {
        let count = self.detailText.text.count
        self.countLabel.text = "\((0) + count)/300자"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == detailText){
            return textView.text.count +  (text.count - range.length) <= 300
        }
        return false
        
        /*if text == "\n" {
            textView.resignFirstResponder()
        }
        return true*/
    }
    
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    /*
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailText.text == "" {
            textViewSetupView()
        }
    }
    
    func textViewSetupView() {
        if detailText.text == "ex) 연애에 있어서 다양한 고민이 복잡하게 얽혀있어 머릿속이 복잡해요." {
            detailText.textColor = UIColor.lightGray
        } else if detailText.text == "" {
            detailText.text == "ex) 연애에 있어서 다양한 고민이 복잡하게 얽혀있어 머릿속이 복잡해요."
            detailText.textColor = UIColor.black
        }
    }*/
}
