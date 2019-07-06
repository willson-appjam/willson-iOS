//
//  HelperRequestViewController.swift
//  Willson
//
//  Created by JHKim on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperRequestViewController: UIViewController {
    
    // MARK: - prorperties
    let requestCollectionCellIdentifier: String = "HelperRequestCollectionViewCell"

    // MARK: - IBOutlet
    @IBOutlet weak var helperRequestCollectionView: UICollectionView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UICollectionView delegate, dataSource
        helperRequestCollectionView.delegate = self
        helperRequestCollectionView.dataSource = self
    }
}

extension HelperRequestViewController: UICollectionViewDelegate {
    
}

extension HelperRequestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HelperRequestCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: requestCollectionCellIdentifier, for: indexPath) as? HelperRequestCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

extension HelperRequestViewController: UICollectionViewDelegateFlowLayout {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 333, height: 264)
    }
}
