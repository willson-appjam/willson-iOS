//
//  HelperRequestViewController.swift
//  Willson
//
//  Created by JHKim on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperRequestViewController: UIViewController {
    
    // MARK: - prorperties
    let requestTitleCollectionCellIdentifier: String = "HelperRequestTitleCollectionViewCell"
    let requestCollectionCellIdentifier: String = "HelperRequestCollectionViewCell"
    
    private var rightBarButton = UIBarButtonItem()

    // MARK: - IBOutlet
    @IBOutlet weak var helperRequestCollectionView: UICollectionView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UICollectionView delegate, dataSource
        helperRequestCollectionView.delegate = self
        helperRequestCollectionView.dataSource = self
        
        // UINavagationBar Title Logo
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "imgLogo"))
        
        // UINavagationBar right button - Switch Asker
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btnSwitch"), for: .normal)
        button.setTitle("고민자전환", for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12)
        button.tintColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.3019607843, alpha: 1)
        button.sizeToFit()
        self.rightBarButton = UIBarButtonItem(customView: button)
        
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = self.rightBarButton
        
        // UINavigation bar hide line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // UITabBar hide line
        /* 적용이 안돼요
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
        self.tabBarController?.tabBar.layer.shadowRadius = 6
        self.tabBarController?.tabBar.layer.shadowOpacity = 0.16
         */
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    // MARK: - IBAction
    
    // MARK: - Methods
    @objc func someAction() {
        let storyboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerTabbar")
        present(viewController, animated: true)
    }
    
}

// MARK: - UICollectionViiewDelegate
extension HelperRequestViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension HelperRequestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 5
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: HelperRequestTitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: requestTitleCollectionCellIdentifier, for: indexPath) as? HelperRequestTitleCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell: HelperRequestCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: requestCollectionCellIdentifier, for: indexPath) as? HelperRequestCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HelperRequestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return CGSize(width: view.bounds.width, height: 130)
        case 1: return CGSize(width: 333, height: 264)
        default: return CGSize(width: 0, height: 0)
        }
    }
}
