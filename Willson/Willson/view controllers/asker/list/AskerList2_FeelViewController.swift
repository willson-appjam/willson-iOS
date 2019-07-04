//
//  AskerList2_FeelViewController.swift
//  Willson
//
//  Created by JHKim on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerList2_FeelViewController: UIViewController {
    
    // MARK: - properties
    let feelCollectionViewCellIdentifier: String = "FeelCollectionViewCell"
    
    let feelArray: [String] = ["#신남", "#행복", "#자신감", "#자랑스러운", "#당황스러운", "#지친", "#슬픈", "#두려운", "#무기력한", "#어색한", "#걱정스러운", "#질투나는", "#무서운", "#아픈"]
    
    // MARK: - IBOutlet
    @IBOutlet weak var feelCollectionView: UICollectionView!
    
    // MARK: - IBAction
    @IBAction func tappedCancelBarButton(_ sender: Any) {
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UICollectionView delegate, datasource
        feelCollectionView.delegate = self
        feelCollectionView.dataSource = self
        
        feelCollectionView.register(FeelCollectionViewCell.self, forCellWithReuseIdentifier: feelCollectionViewCellIdentifier)
    }
}

extension AskerList2_FeelViewController: UICollectionViewDelegate {
    
}

extension AskerList2_FeelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: feelCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return UICollectionViewCell() }
        cell.feelLabel.text = feelArray[indexPath.item]
        return cell
    }
    
    
}

extension AskerList2_FeelViewController: UICollectionViewDelegateFlowLayout {
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: feelCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return CGSize(width: 0, height: 0) }
        cell.feelLabel.text = feelArray[indexPath.item]
        cell.feelLabel.sizeToFit()
        let width = cell.feelLabel.bounds.width
        return CGSize(width: width, height: 32)
    }
 */
}
