//
//  AskerRequestViewController.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerRequestViewController: UIViewController {
    
    // MARK: - properties
    //===================================
    //임시 데이터 저장 코드
    var helpers:[HelperCollectionViewCell] = [];
    var count = 300
    var timer = Timer()
    var startTimer = false
    var extended = false
    var completionHandlers: [() -> Void] = []
    
    var helperList: HelperList?
    var helperListData: [HelperListData]?
    var questionID = 1
    //===================================
    
    // MARK: - IBOutlet
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var helperCollectionView: UICollectionView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHelperList()
        
        startTimer = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AskerRequestViewController.timeLimit), userInfo: nil, repeats: true)
        
//        registerCVC()
//        helpers = getHelper()
        helperCollectionView.delegate = self
        helperCollectionView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AskerRequestViewController.goPage))
        
//        self.helperCollectionView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Methods
    func getHelperList() {
        HelperListService.shared.getHelperList(questionID: questionID) {
            helperList, statusCode in
            switch statusCode {
            case 200:
                self.helperList = helperList
                self.helperListData = self.helperList?.data
                break;
            default:
                break;
            }
        }
    }
    
    @objc func goPage(sender:UIGestureRecognizer)
        
    {
        let storyboard  = UIStoryboard(name: "AskerRequest", bundle: nil)
   
        guard let vc = storyboard.instantiateViewController(withIdentifier: "HelperProfileViewController") as? HelperProfileViewController else { return }
        
        self.navigationController?.show(vc, sender: nil)
    }
    
    @objc func timeLimit() {
        let dateFormatter = DateFormatter()
        
        if count > 0 {
            count -= 1
            time.text = "\(count/60):\(count%60)"
            dateFormatter.dateFormat = "mm:ss"
            
            let formattime = dateFormatter.date(from:time.text!)
            time.text = dateFormatter.string(from: formattime!)
            
        } else {
            timeLimitStop()
        }
    }
    
    func timeLimitStop() {
        timer.invalidate()
        
        if (extended == false) { //처음 5분 연장했을 때의 팝업창
            let popOverVC = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier:
                "CantFindHelperViewController") as! CantFindHelperViewController

            popOverVC.preferredContentSize.width = 323
            popOverVC.preferredContentSize.height = 304
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.setValue(popOverVC, forKey: "contentViewController")
            
            self.present(alert, animated: true)

        }
        else { //두번째 5분 연장했을 때의 팝업창
            let popOverVC = UIStoryboard(name: "AskerRequest", bundle: nil).instantiateViewController(withIdentifier:
                "CantFindHelperViewController") as! CantFindHelperViewController
            
        }
    }
    
}

extension AskerRequestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
            
            //helperListData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelperCollectionViewCell", for: indexPath) as! HelperCollectionViewCell
        
    
        let helper = helpers[indexPath.row]
        
        cell.content.text = helper.content.text
        cell.name.text = helper.name.text
        cell.detailInfo.text = helper.detailInfo.text
        cell.category.text = helper.category.text
        
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AskerRequestViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AskerRequestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (helperCollectionView.frame.width)
        let height: CGFloat = 284
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController { if let selected = tab.selectedViewController { return topViewController(base: selected) } }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
