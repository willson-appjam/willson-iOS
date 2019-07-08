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
    // MARK: - IBOutlet
    @IBOutlet weak var concernCollectionView: UICollectionView!

    // MARK: - IBAction
    @IBAction func tappedCancelBarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UICollectionView delegate, datasource
        concernCollectionView.delegate = self
        concernCollectionView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        
        view.addGestureRecognizer(tap) //밖의 뷰를 탭했을 경우
        //concernCell.addGestureRecognizer(tap) //셀을 탭했을 경우
    }
    
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ConcernCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: concernCollectionCellIdentifier, for: indexPath) as? ConcernCollectionViewCell else { return UICollectionViewCell() }
    
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
            cell.concernLabel.isHidden = true
            cell.concernTextField.isHidden = false
            cell.concernTextField.text = "+ 직접입력"
        default:
            return cell
        }
        
        return cell
    }
}

extension AskerList1_CategoryViewController: UICollectionViewDelegateFlowLayout {
    
}


