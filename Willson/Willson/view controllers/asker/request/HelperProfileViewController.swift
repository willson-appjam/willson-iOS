//
//  HelperProfileViewController.swift
//  Willson
//
//  Created by 박지수 on 02/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class HelperProfileViewController: UIViewController {
   
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var startBtn: MDCFloatingButton!
    @IBOutlet weak var HelperReviewCV: UICollectionView!
    
    var count = 0
    var reviews:[HelperReviewCollectionViewCell] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        registerCVC()
        reviews = getReview()
        HelperReviewCV.delegate = self
        HelperReviewCV.dataSource = self
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "헬퍼 프로필"
        //self.setBackBtn(color: UIColor.black)
        //self.setNavigationBarShadow()
    }
    
    func registerCVC() {
        let nibName = UINib(nibName: "HelperReviewCollectionViewCell", bundle: nil)
        HelperReviewCV.register(nibName, forCellWithReuseIdentifier: "HelperReviewCollectionViewCell")
    }
    
    func getReview() -> [HelperReviewCollectionViewCell] {
        //===================================
        //임시 데이터 저장 코드
        let review1:HelperReviewCollectionViewCell = Bundle.main.loadNibNamed("HelperReviewCollectionViewCell", owner: self, options: nil)?.first as! HelperReviewCollectionViewCell
        review1.category.text = "진로"
        review1.name.text = "성격과 행동에 관해 고찰 중인 고민둥이님"
        review1.date.text = "2019.06.13"
        review1.content.text = "1경험을 통해서 위로를 받고 누군가에게 고민을 속 깊게 털어놓을 수 있다는 자체가 너무 좋았습니다."
         //review1.starReview
        
        let review2:HelperReviewCollectionViewCell = Bundle.main.loadNibNamed("HelperReviewCollectionViewCell", owner: self, options: nil)?.first as! HelperReviewCollectionViewCell
        review2.category.text = "진로"
        review2.name.text = "연애, 진로 다양한 고민이 복잡하게 얽혀있어 가장 힘든 한 해를 보냈던 파도님"
        review2.date.text = "2019.06.13"
        review2.content.text = "2경험을 통해서 위로를 받고 누군가에게 고민을 속 깊게 털어놓을 수 있다는 자체가 너무 좋았습니다."
        //review1.starReview
        
        let review3:HelperReviewCollectionViewCell = Bundle.main.loadNibNamed("HelperReviewCollectionViewCell", owner: self, options: nil)?.first as! HelperReviewCollectionViewCell
        review3.category.text = "진로"
        review3.name.text = "성격과 행동에 관해 고찰 중인 고민둥이님"
        review3.date.text = "2019.06.13"
        review3.content.text = "3경험을 통해서 위로를 받고 누군가에게 고민을 속 깊게 털어놓을 수 있다는 자체가 너무 좋았습니다."
        //review1.starReview
        //===================================
        
        return [review1, review2, review3]
    }
}


extension HelperProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return reviews.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelperReviewCollectionViewCell", for: indexPath) as! HelperReviewCollectionViewCell
        
        let review = reviews[indexPath.row]
        
        cell.category.text = review.category.text
        cell.name.text = review.name.text
        cell.date.text = review.date.text
        cell.content.text = review.content.text
        //starReview
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
           
            return view
        }
        fatalError("Unexpected kind")
    }
}

extension HelperProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HelperProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (HelperReviewCV.frame.width) - 34
        let height: CGFloat = 180
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 74, left: 0, bottom: 74, right: 0)
    }
}

