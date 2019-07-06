//
//  HelperEnrollDetailCategoryViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperEnrollDetailCategoryViewController: UIViewController {

    let detailCategoryCollectionCellIdentifier: String = "ConcernCollectionViewCell"
    
    @IBOutlet weak var DetailCateCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumSquareB", size: 21.0)!];
        
        DetailCateCV.delegate = self
        DetailCateCV.dataSource = self
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
    }
    
}

extension HelperEnrollDetailCategoryViewController: UICollectionViewDelegate {
    
}

extension HelperEnrollDetailCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ConcernCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionCellIdentifier, for: indexPath) as? ConcernCollectionViewCell else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = "짝사랑"
        case 1:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = "썸"
        case 2:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = "갈등"
        case 3:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = "이별"
        case 4:
            cell.concernLabel.isHidden = false
            cell.concernTextField.isHidden = true
            cell.concernLabel.text = "+ 직접입력"
        default:
            return cell
        }
        
        return cell
    }
}

extension HelperEnrollDetailCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153.0, height: 50.0)
    }
}

