//
//  AskerList1_CategoryViewController.swift
//  Willson
//
//  Created by JHKim on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList1_CategoryViewController: UIViewController {
    
    // MARK: - properties
    let concernCollectionCellIdentifier: String = "ConcernCollectionViewCell"
    var placeHolder = ""
    var categoryID: Int!
    var categoryTitle: String!
    var tapCnt = 0
    
    var concernCategory: ConcernCategory?
    var dataList: ConcernCategoryData?
    
    // MARK: - IBOutlet
    @IBOutlet weak var concernCollectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    
    // MARK: - IBAction
    @IBAction func tappedCancelBarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        // UICollectionView delegate, datasource
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        
        //view.addGestureRecognizer(tap) //밖의 뷰를 탭했을 경우
        //concernCell.addGestureRecognizer(tap) //셀을 탭했을 경우
        //enableBtn()
        concernCollectionView.allowsMultipleSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        concernCollectionView.delegate = self
        concernCollectionView.dataSource = self
    }
    
    func getCategory() {
        ConcernCategoryService.shared.getCategory(categoryID: categoryID) { concernCategory, statusCode in
            switch statusCode {
            case 200:
                self.concernCategory = concernCategory
                self.dataList = self.concernCategory?.data
                break;
            default:
                break;
            }
        }
    }

    func enableBtn() {
        if(tapCnt == 0 ) {
            nextBtn.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)
            nextBtn.isEnabled = false
        } else {
            nextBtn.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            nextBtn.isEnabled = true
        }
    }
    
    /*@objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        
    }*/
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "" {
//            guard let nextVC: AskerList2_FeelViewController = segue.destination as? AskerList2_FeelViewController else { return }
//            nextv
//        }
//    }
}

extension AskerList1_CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: ConcernCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: concernCollectionCellIdentifier, for: indexPath) as? ConcernCollectionViewCell else { return }
        
        cell.concernTextField.text = ""
        placeHolder = cell.concernTextField.text ?? ""
        
        cell.isSelected = !cell.isSelected
        if (cell.isSelected)
        {
            cell.view.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            cell.concernLabel.textColor = UIColor.white
            tapCnt = tapCnt - 1
        }
        else
        {
            cell.view.backgroundColor = UIColor.white
            cell.concernLabel.textColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
            tapCnt = tapCnt + 1
        }
        //cell.isSelected = !cell.isSelected
       
        print(tapCnt)
    }
    
}

extension AskerList1_CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataList?.categoryList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ConcernCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: concernCollectionCellIdentifier, for: indexPath) as? ConcernCollectionViewCell else { return UICollectionViewCell() }
    
        switch indexPath.item {
        case (dataList?.categoryList.count ?? 0) - 1:
            cell.concernLabel.isHidden = true
            cell.concernTextField.isHidden = false
            cell.concernTextField.text = "+ 직접입력"
        default:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = dataList?.categoryList[indexPath.item].categoryListName
        }
        
        return cell
    }
}

extension AskerList1_CategoryViewController: UICollectionViewDelegateFlowLayout {
    
}


