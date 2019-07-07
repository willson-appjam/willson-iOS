//
//  SplashViewController.swift
//  Willson
//
//  Created by JHKim on 07/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class SplashViewController: UIViewController {
    
    // MARK: - properties
    let delayInSeconds = 3.5 //스플래시 딜레이 시간
    
    @IBOutlet weak var splashImageView: UIImageView!
    
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //서버 접속 불가일 때랑 인터넷 연결 안될경우 예외처리 필요함
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.showLogin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gif 이미지 띄우기
        splashImageView.image = UIImage.gif(asset: "splash")
    }
    
    // MARK: - Methods
    func showLogin() {
        let storyboard = UIStoryboard(name: "AskerLogin", bundle: nil)
        guard let viewController: AskerLoginViewController = storyboard.instantiateViewController(withIdentifier: "AskerLoginViewController") as? AskerLoginViewController else { return }
        present(viewController, animated: false)
    }
    
}
