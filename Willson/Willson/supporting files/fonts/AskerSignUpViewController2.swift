//
//  AskerSignUpViewController2.swift
//  Willson
//
//  Created by 박지수 on 30/06/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerSignUpViewController2: UIViewController {
    
    // MARK: - properties
    let characterCollectionViewCellIdentifier: String = "FeelCollectionViewCell"
    let characterArray = ["#신중한", "#호의적인", "#경쟁심있는", "#절제하는", "#열정적인", "#상냥한", "#단호한", "#내향적인", "#사교적인", "#충동적인", "#변덕스러운", "#독립적인", "#고집있는", "#모험적인", "#분석적인", "#주저하는", "#낙천적인", "#감성적인", "#대담한", "#우유부단한", "#솔직한" ,"#이끌어가는"]
    // MARK: - IBOutlet
    @IBOutlet weak var characterCollectionView: UICollectionView!
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        characterCollectionView.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func tappedStartWillsonBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerTabbar")
        self.present(viewController, animated: true)
    }
    
    // MARK: Methods

}

extension AskerSignUpViewController2: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return }
        cell.view.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
        cell.feelLabel.textColor = UIColor.white
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return }
        cell.view.backgroundColor = UIColor.white
        cell.feelLabel.textColor = #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.631372549, alpha: 1)
    }
}

extension AskerSignUpViewController2: UICollectionViewDataSource {
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FeelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCollectionViewCellIdentifier, for: indexPath) as? FeelCollectionViewCell else { return UICollectionViewCell() }
        if let label = cell.feelLabel {
            label.text = characterArray[indexPath.item]
        }
        
        
        //셀의 너비를 데이터의 크기에 따라 유동적 변경
        cell.feelLabel.sizeToFit()
        cell.view.sizeToFit()
        
        return cell
    }
    
}
