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
    
    var concernCategory: ConcernCategory?
    var dataList: DataClass?
    // MARK: - IBOutlet
    @IBOutlet weak var concernCollectionView: UICollectionView!

    // MARK: - IBAction
    @IBAction func tappedCancelBarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    func viewWillAppear() {
        getCategory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        // UICollectionView delegate, datasource
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        
        view.addGestureRecognizer(tap) //밖의 뷰를 탭했을 경우
        //concernCell.addGestureRecognizer(tap) //셀을 탭했을 경우
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
    
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
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


