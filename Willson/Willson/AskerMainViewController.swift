//
//  AskerMainViewController.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerMainViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - properties
    var slideList: [Slide] = []
    var reviewSlides: [ReviewSlide] = []
    
    var timer = Timer()
    var timer2 = Timer()
    
    var helperStory: HelperStory?
    var dataList: [HelperStoryData]?
    
    var reviewStory: ReviewStory?
    var reviewStoryData: [ReviewStoryData]?
    
    private var rightBarButton = UIBarButtonItem()

    // MARK: - IBOutlet
    @IBOutlet weak var concern1View: UIView!
    @IBOutlet weak var concern2View: UIView!
    @IBOutlet weak var concern3View: UIView!
    @IBOutlet weak var concern4View: UIView!
    @IBOutlet weak var concern5View: UIView!
    @IBOutlet weak var concern6View: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView! //헬퍼들의 이야기 좌우스크롤뷰
    @IBOutlet weak var AskerScrollView: UIScrollView!
    
    // MARK: - life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // helper story networking
        getHelperStory()
        // review story networking
        getReviewStory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        slideList = createSlides()
        setupSlideScrollView(slides: slideList)
        
        reviewSlides = createReviewSlides()
        setupReviewSlideScrollView(reviewSlides: reviewSlides)
        
        scrollView.delegate = self
        AskerScrollView.delegate = self
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // 카테고리 UIView에 touch Action 추가
        let concern1Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        let concern2Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        let concern3Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        let concern4Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        let concern5Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        let concern6Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern(_:)))
        
        
        concern1View.addGestureRecognizer(concern1Gesture)
        concern2View.addGestureRecognizer(concern2Gesture)
        concern3View.addGestureRecognizer(concern3Gesture)
        concern4View.addGestureRecognizer(concern4Gesture)
        concern5View.addGestureRecognizer(concern5Gesture)
        concern6View.addGestureRecognizer(concern6Gesture)
        
        //헬퍼
        
//        getHelperStory()
        
//        slideList = createSlides()
//        setupSlideScrollView(slides: slideList)
        
        
        
//        pageControl.numberOfPages = slides.count - 1
//        pageControl.currentPage = 0
//        scrollView.bringSubviewToFront(pageControl)
        
        
        //질문자
        
        
        
        
//        ReviewPageControl.numberOfPages = reviewSlides.count - 1
//        ReviewPageControl.currentPage = 0
//        AskerScrollView.bringSubviewToFront(ReviewPageControl)
        
        //자동 스크롤
        timer = Timer.scheduledTimer(timeInterval:6, target:self, selector:#selector(AskerMainViewController.autoScroll), userInfo:nil, repeats:true)
    
        // UINavagationBar Title Logo
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "imgLogo"))
        
        // UINavagationBar right button - Switch Asker
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btnSwitch"), for: .normal)
        button.setTitle("헬퍼전환", for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12)
        button.tintColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.3019607843, alpha: 1)
        button.sizeToFit()
        self.rightBarButton = UIBarButtonItem(customView: button)
        
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = self.rightBarButton
        
        // UINavigation bar hide line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // UITabBar hide line
        /* 적용이 안돼요
         self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
         self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
         self.tabBarController?.tabBar.layer.shadowRadius = 6
         self.tabBarController?.tabBar.layer.shadowOpacity = 0.16
         */
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    // MARK: - IBAction
    @IBAction func userTransition(_ sender: Any) {
        let storyboard  = UIStoryboard(name: "HelperTabbar", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "HelperTabbar")
        
        present(vc, animated: true)
    }
    
    // MARK: - Methods
    @objc func someAction() {
        let storyboard = UIStoryboard(name: "HelperTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HelperTabbar")
        present(viewController, animated: true)
    }
    
    @objc func tappedconcern(_ gesture: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "AskerList", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AskerListStartViewController") as? AskerListStartViewController else { return }
        let navi = UINavigationController(rootViewController: vc)
        navi.navigationBar.tintColor = .black
        
        let v = gesture.view!
    
        vc.tag = v.tag
        vc.label = v.accessibilityLabel
        
//        navigationController?.pushViewController(vc, animated: true)
        self.present(navi, animated: true)
    }
    
    @objc func autoScroll() {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + scrollView.frame.width, y: 0), animated: true)
        self.AskerScrollView.setContentOffset(CGPoint(x: self.AskerScrollView.contentOffset.x + AskerScrollView.frame.width, y: 0), animated: true)
    }

    //통신 함수
    func getHelperStory() {
        HelperStoryService.shared.getHelperStory() { helperStory, statusCode in
            switch statusCode {
            case 200:
                self.helperStory = helperStory
                self.dataList = self.helperStory?.data
                //self.scrollView.reloadInputViews()
                break;
            default:
                //self.simpleAlert(title: "통신 실패", message: "네트워크 상태로 확인하세요.")
                break;
            }
        }
    }
    
    func getReviewStory() {
        ReviewStoryService.shared.getReviewStory() {
            reviewStory, statusCode in
            switch statusCode {
            case 200:
                self.reviewStory = reviewStory
                self.reviewStoryData = self.reviewStory?.data
                break;
            default:
                break;
            }
        }
    }
    
    func createSlides() -> [Slide] {
        let Slide0:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide0.name.text = dataList?[0].nickname
        Slide0.content.text = dataList?[0].content
        Slide0.category.text = dataList?[0].categoryName
        
        let Slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide1.name.text = dataList?[1].nickname
        Slide1.content.text = dataList?[1].content
        Slide1.category.text = dataList?[1].categoryName
        
        let Slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide2.name.text = dataList?[2].nickname
        Slide2.content.text = dataList?[2].content
        Slide2.category.text = dataList?[2].categoryName
        
        let Slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide3.name.text = dataList?[3].nickname
        Slide3.content.text = dataList?[3].content
        Slide3.category.text = dataList?[3].categoryName
        
        let Slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide4.name.text = dataList?[4].nickname
        Slide4.content.text = dataList?[4].content
        Slide4.category.text = dataList?[4].categoryName
        
        let Slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        
        Slide5.name.text = dataList?[0].nickname
        Slide5.content.text = dataList?[0].content
        Slide5.category.text = dataList?[0].categoryName
        
        return [Slide0, Slide1, Slide2, Slide3, Slide4, Slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slideList.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slideList.count {
            slideList[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slideList[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        if(percentOffset.x > 0 && percentOffset.x <= 0.2) {
            slideList[0].mask?.transform = CGAffineTransform(scaleX: (0.2-percentOffset.x)/0.2, y: (0.2-percentOffset.x)/0.2)
            slideList[1].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.2, y: percentOffset.x/0.2)
            
        } else if(percentOffset.x > 0.2 && percentOffset.x <= 0.4) {
            slideList[1].mask?.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.2, y: (0.4-percentOffset.x)/0.2)
            slideList[2].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
            
        } else if(percentOffset.x > 0.4 && percentOffset.x <= 0.6) {
            slideList[2].mask?.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.2, y: (0.6-percentOffset.x)/0.2)
            slideList[3].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
            
        } else if(percentOffset.x > 0.6 && percentOffset.x <= 0.8) {
            slideList[3].mask?.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.2, y: (0.8-percentOffset.x)/0.2)
            slideList[4].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
        } else if(percentOffset.x > 0.8 && percentOffset.x <= 1) {
//            pageControl.currentPage = 0
            slideList[4].mask?.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
            slideList[5].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
           
        } else if(percentOffset.x > 1) {
            let offset = CGPoint(x: 0, y: -scrollView.adjustedContentInset.top)
            scrollView.setContentOffset(offset, animated: false)
        }
    }
    
    
    func createReviewSlides() -> [ReviewSlide] {
       let ReviewSlide1:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
       
        ReviewSlide1.category.text = reviewStoryData?[0].categoryName
        ReviewSlide1.content.text = reviewStoryData?[0].content
        ReviewSlide1.asker.text = "- \(reviewStoryData?[0].nickname ?? "")님-"
        
        let ReviewSlide2:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide2.category.text = reviewStoryData?[1].categoryName
        ReviewSlide2.content.text = reviewStoryData?[1].content
        ReviewSlide2.asker.text = "- \(reviewStoryData?[1].nickname ?? "")님-"
        
        let ReviewSlide3:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide3.category.text = reviewStoryData?[2].categoryName
        ReviewSlide3.content.text = reviewStoryData?[2].content
        ReviewSlide3.asker.text = "- \(reviewStoryData?[2].nickname ?? "")님-"
        
        let ReviewSlide4:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide4.category.text = reviewStoryData?[3].categoryName
        ReviewSlide4.content.text = reviewStoryData?[3].content
        ReviewSlide4.asker.text = "- \(reviewStoryData?[3].nickname ?? "")님-"
        
        let ReviewSlide5:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide5.category.text = reviewStoryData?[4].categoryName
        ReviewSlide5.content.text = reviewStoryData?[4].content
        ReviewSlide5.asker.text = "- \(reviewStoryData?[4].nickname ?? "")님-"
        
        let ReviewSlide6:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide6.category.text = reviewStoryData?[0].categoryName
        ReviewSlide6.content.text = reviewStoryData?[0].content
        ReviewSlide6.asker.text = "- \(reviewStoryData?[0].nickname ?? "")님-"
        
        return [ReviewSlide1, ReviewSlide2, ReviewSlide3, ReviewSlide4, ReviewSlide5, ReviewSlide6]
    }
    
    func setupReviewSlideScrollView(reviewSlides : [ReviewSlide]) {
        AskerScrollView.frame = CGRect(x: 0, y: 0, width: AskerScrollView.frame.width, height: AskerScrollView.frame.height)
        AskerScrollView.contentSize = CGSize(width: AskerScrollView.frame.width * CGFloat(reviewSlides.count), height: AskerScrollView.frame.height)
        AskerScrollView.isPagingEnabled = true
        
        for i in 0 ..< reviewSlides.count {
            reviewSlides[i].frame = CGRect(x: AskerScrollView.frame.width * CGFloat(i), y: 0, width: AskerScrollView.frame.width, height: AskerScrollView.frame.height)
            AskerScrollView.addSubview(reviewSlides[i])
        }
    }
    
    @objc func AskerScrollViewDidScroll(_ AskerScrollView: UIScrollView) {
        let pageIndex = round(AskerScrollView.contentOffset.x/view.frame.width)
//        ReviewPageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = AskerScrollView.contentSize.width - AskerScrollView.frame.width
        let currentHorizontalOffset: CGFloat = AskerScrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = AskerScrollView.contentSize.height - AskerScrollView.frame.height
        let currentVerticalOffset: CGFloat = AskerScrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.2) {
            reviewSlides[0].mask?.transform = CGAffineTransform(scaleX: (0.2-percentOffset.x)/0.2, y: (0.2-percentOffset.x)/0.2)
            reviewSlides[1].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.2, y: percentOffset.x/0.2)
            
        } else if(percentOffset.x > 0.2 && percentOffset.x <= 0.4) {
            reviewSlides[1].mask?.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.2, y: (0.4-percentOffset.x)/0.2)
            reviewSlides[2].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
            
        } else if(percentOffset.x > 0.4 && percentOffset.x <= 0.6) {
            reviewSlides[2].mask?.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.2, y: (0.6-percentOffset.x)/0.2)
            reviewSlides[3].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
            
        } else if(percentOffset.x > 0.6 && percentOffset.x <= 0.8) {
            reviewSlides[3].mask?.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.2, y: (0.8-percentOffset.x)/0.2)
            reviewSlides[4].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
        } else if(percentOffset.x > 0.8 && percentOffset.x <= 1) {
//            ReviewPageControl.currentPage = 0
            reviewSlides[4].mask?.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
            reviewSlides[5].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
            
        } else if(percentOffset.x > 1) {
            let offset = CGPoint(x: 0, y: -AskerScrollView.adjustedContentInset.top)
            AskerScrollView.setContentOffset(offset, animated: false)
        }
    }
}
