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
    
    //===================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCVC()
        helpers = getHelper()
        helperCollectionView.delegate = self
        helperCollectionView.dataSource = self as? UICollectionViewDataSource
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
        //===================================
        
        return [helper1, helper2]
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

extension AskerRequestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (helperCollectionView.frame.width)
        let height: CGFloat = (width) + 20
        
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
