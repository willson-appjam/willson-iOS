//
//  AskerList6_HelperCharacterViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList6_HelperCharacterViewController: UIViewController {
    
    // MARK: - properties
    let characterCollectionViewCellIdentifier: String = "FeelCollectionViewCell"
    let characterArray = ["#신중한", "#호의적인", "#경쟁심있는", "#절제하는", "#열정적인", "#상냥한", "#단호한", "#내향적인", "#사교적인", "#충동적인", "#변덕스러운", "#독립적인", "#고집있는", "#모험적인", "#분석적인", "#주저하는", "#낙천적인", "#감성적인", "#대담한", "#우유부단한", "#솔직한" ,"#이끌어가는"]

    // MARK: - IBOutlet
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UICollectionView delegate, datasource
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
    }
}

extension AskerList6_HelperCharacterViewController: UICollectionViewDelegate {
    
}

extension AskerList6_HelperCharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return UICollectionViewCell() }
        if let label = cell.feelLabel {
            label.text = characterArray[indexPath.item]
        }
        return cell
    }
    
    
}

extension AskerList6_HelperCharacterViewController: UICollectionViewDelegateFlowLayout {
    
}
