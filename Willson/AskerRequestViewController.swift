//
//  AskerRequestViewController.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerRequestViewController: UIViewController {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var helperCollectionView: UICollectionView!
    //===================================
    //임시 데이터 저장 코드
    var helpers:[HelperCollectionViewCell] = [];
    var count = 300
    var timer = Timer()
    var startTimer = false
    //===================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AskerRequestViewController.timeLimit), userInfo: nil, repeats: true)
        
        registerCVC()
        helpers = getHelper()
        helperCollectionView.delegate = self
        helperCollectionView.dataSource = self
    }
    
    @objc func timeLimit() {
        if count > 0 {
            count -= 1
            time.text = "\(count/60):\(count%60)"
        } else {
            timeLimitStop()
        }
    }
    
    func timeLimitStop() {
        startTimer = false
        timer.invalidate()
    }
    
    func registerCVC() {
        let nibName = UINib(nibName: "HelperCollectionViewCell", bundle: nil)
        helperCollectionView.register(nibName, forCellWithReuseIdentifier: "HelperCollectionViewCell")
    }
    
    func getHelper() -> [HelperCollectionViewCell] {
        //===================================
        //임시 데이터 저장 코드
        let helper1:HelperCollectionViewCell = Bundle.main.loadNibNamed("HelperCollectionViewCell", owner: self, options: nil)?.first as! HelperCollectionViewCell
        helper1.category.text = "안녕"
        helper1.name.text = "세인트버나드"
        helper1.detailInfo.text = "남자 / 10대 초반"
        helper1.content.text = "배가 고파요.. 졸려요.."
        
        let helper2:HelperCollectionViewCell = Bundle.main.loadNibNamed("HelperCollectionViewCell", owner: self, options: nil)?.first as! HelperCollectionViewCell
        helper2.category.text = "일상"
        helper2.name.text = "골든리트리버"
        helper2.detailInfo.text = "여자 / 30대 초반"
        helper2.content.text = "회사가기 싫어용ㅠㅠ"
        
        let helper3:HelperCollectionViewCell = Bundle.main.loadNibNamed("HelperCollectionViewCell", owner: self, options: nil)?.first as! HelperCollectionViewCell
        helper3.category.text = "일상"
        helper3.name.text = "푸들"
        helper3.detailInfo.text = "여자 / 20대 초반"
        helper3.content.text = "밥먹자"
        //===================================
        
        return [helper1, helper2, helper3]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension AskerRequestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return helpers.count
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

extension AskerRequestViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AskerRequestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (helperCollectionView.frame.width)
        let height: CGFloat = 251
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
