//
//  AskerList9_AgreementViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList9_AgreementViewController: UIViewController {

    // MARK: - properties
    var concernQuestion: ConcernQuestion?
    var concernQuestionPost: ConcernQuestionPost?
    
    var statusCode: Int?
    
    // Concern Question Post
    var categoryListIdx: Int = 0
    var feelingArray: [Int] = []
    var weight: Int = 0
    var content: String = ""
    var gender: String = ""
    var personalityArray: [Int] = []
    var experienceArray: [String] = []
    var emotion: Int = 0
    var advise: Int = 0
    var experience: Int = 0
    
    // MARK: - IBOutlet
    @IBOutlet weak var agreeButton1: UIButton!
    @IBOutlet weak var agreeButton2: UIButton!
    
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedComplete(_ sender: Any) {
        /*
        let question = Question(content: content, weight: weight, emotion: emotion, advise: advise, experience: experience, agreement: "agree", categoryListIdx: categoryListIdx, helperGender: gender)
       concernQuestionPost = ConcernQuestionPost(question: question, feeling: feelingArray, personality: personalityArray, experience: experienceArray)
        ConcernQuestionService.shared.postConcernQuestionService(concernQuestionPost: concernQuestionPost!) { concernQuestion, statusCode in
            switch statusCode {
            case 200:
                self.concernQuestion = concernQuestion
                self.statusCode = statusCode
                //화면 이동
                let tabbarStoryboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
                guard let tabBarController: UITabBarController = tabbarStoryboard.instantiateViewController(withIdentifier: "AskerTabbar") as? UITabBarController else { return }
                
                guard let vc = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier: "searchingHelperNavi") as? UINavigationController else { return }
                
                tabBarController.selectedIndex = 1
                tabBarController.selectedViewController = vc
                
                self.present(tabBarController, animated: true)
            default:
                break;
            }
        }
 */
        let tabbarStoryboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        guard let tabBarController: UITabBarController = tabbarStoryboard.instantiateViewController(withIdentifier: "AskerTabbar") as? UITabBarController else { return }
        
        guard let vc = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier: "searchingHelperNavi") as? UINavigationController else { return }
        
        tabBarController.selectedIndex = 1
        tabBarController.viewControllers?[1] = vc
        tabBarController.tabBar.selectionIndicatorImage = UIImage(named: "tab02RequestActive")
        tabBarController.tabBarItem.title = "받은요청"
        
        self.present(tabBarController, animated: true)
        
    }
    
    @IBAction func tappedAgree1(_ sender: Any) {
        agreeButton1.isSelected = true
    }
    
    @IBAction func tappedAgree2(_ sender: Any) {
        agreeButton2.isSelected = true
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
