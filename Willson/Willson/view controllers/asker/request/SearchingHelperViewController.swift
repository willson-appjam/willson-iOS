//
//  SearchingHelperViewController.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class SearchingHelperViewController: UIViewController {

    // MARK: - properties
    var timer = Timer()
    var count = 10
    var completionHandlers: [() -> Void] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLimit), userInfo: nil, repeats: true)
    }

    // MARK: - Methods
    @objc func timeLimit() {
        let dateFormatter = DateFormatter()
        
        if count > 0 {
            count -= 1
            timeLabel.text = "\(count/60):\(count%60)"
            dateFormatter.dateFormat = "mm:ss"
            
            let formattime = dateFormatter.date(from:timeLabel.text!)
            timeLabel.text = dateFormatter.string(from: formattime!)
            
        } else {
            timeLimitStop()
        }
    }
    
    func timeLimitStop() {
        timer.invalidate()
        
        let tabbarStoryboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        guard let tabBarController: UITabBarController = tabbarStoryboard.instantiateViewController(withIdentifier: "AskerTabbar") as? UITabBarController else { return }
        
        tabBarController.selectedIndex = 1
        
        guard let container = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier: "askerRequestNavi") as? UINavigationController else { return }
        
        tabBarController.viewControllers?[1] = container
        tabBarController.tabBar.items?[1].image = UIImage(named: "tab02RequestActive")
        tabBarController.tabBar.items?[1].title = "받은요청"
        
        self.present(tabBarController, animated: true)
    }
}
