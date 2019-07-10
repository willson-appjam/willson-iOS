//
//  AskerListStartViewController.swift
//  Willson
//
//  Created by JHKim on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerListStartViewController: UIViewController {
    var tag: Int!
    var label: String!
    
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    // MARK: - IBAction
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        var imgName = "listImgCategory0\(String(tag))"
        print(imgName)
        labelCategory.text = label
        imgCategory.image = UIImage(named: imgName)
        
    }
    
    @IBAction func startActionBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AskerList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerList1_CategoryViewController") as! AskerList1_CategoryViewController
        viewController.categoryID = tag
        viewController.categoryTitle = label
        
        present(viewController, animated: true)
    }
    
}
