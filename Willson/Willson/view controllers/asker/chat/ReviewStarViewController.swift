//
//  ReviewStarViewController.swift
//  Willson
//
//  Created by JHKim on 05/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ReviewStarViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var selectStarLabel: UILabel!
    @IBOutlet weak var StarCommentLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func tappedCheckButton(_ sender: Any) {
        
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // add TapGestrue at StackView
        let starGesture = UILongPressGestureRecognizer(target: self, action: #selector(draggingStars(_:)))
        starStackView.addGestureRecognizer(starGesture)
    }

    // MARK: - Methods
    @objc private func draggingStars(_ gesture: UILongPressGestureRecognizer) {
        self.view.endEditing(true)
        let point = gesture.location(in: starStackView)
        
        switch gesture.state {
        case .began, .changed: changingStars(point.x)
        default: break;
        }
    }
       
    private func changingStars(_ point: CGFloat) {
        var ratingNumber = 0.0
        
        let viewWidth = starStackView.frame.size.width / 10
        let divideRating = Int(point / viewWidth / 2)
        
        var starImage =  UIImage(named: "chatBtnReviewStarBlank")
        for (index, subview) in starStackView.arrangedSubviews.enumerated() {
            if let imageSubview = subview as? UIImageView {
                if (index < divideRating) {
                    starImage =  UIImage(named: "chatBtnReviewStarYellow")
                    ratingNumber += 1.0
                } else {
                    starImage = UIImage(named: "chatBtnReviewStarBlank")
                }
                imageSubview.image = starImage
            }
        }
        
        selectStarLabel.text = "\(Int(ratingNumber))"
    }

}
