//
//  AskerList5_HelperSexViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList5_HelperSexViewController: UIViewController {
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn1Action(_ sender: Any) {
      
            let button : UIButton = (sender as? UIButton)!
            changeBtnColor(button: button)
       
    }
    
    @IBAction func btn2Action(_ sender: Any) {
      
            let button : UIButton = (sender as? UIButton)!
            changeBtnColor(button: button)
        
    }
    
    @IBAction func btn3Action(_ sender: Any) {
       
            let button : UIButton = (sender as? UIButton)!
            changeBtnColor(button: button)
        
    }
    
    func changeBtnColor(button: UIButton) {
        button.isSelected = !button.isSelected
        
        if (button.isSelected)
        {
            button.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            button.titleLabel?.textColor = UIColor.white
           // btnCount = btnCount - 1
        }
            
        else
        {
            button.backgroundColor = UIColor.white
            button.titleLabel?.textColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
           // btnCount = btnCount + 1
        }
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
