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
    
    private var rightBarButton = UIBarButtonItem()

    // MARK: - IBOutlet
    @IBOutlet weak var concern1View: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView! //헬퍼들의 이야기 좌우스크롤뷰
    @IBOutlet weak var AskerScrollView: UIScrollView!
    
    // MARK: - life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // helper story networking
        getHelperStory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카테고리 UIView에 touch Action 추가
        let concern1Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern1(_:)))
        concern1View.addGestureRecognizer(concern1Gesture)
        
        //헬퍼
        scrollView.delegate = self
        
        slideList = createSlides()
        setupSlideScrollView(slides: slideList)
        
//        pageControl.numberOfPages = slides.count - 1
//        pageControl.currentPage = 0
//        scrollView.bringSubviewToFront(pageControl)
        
        
        //질문자
        AskerScrollView.delegate = self
        
        reviewSlides = createReviewSlides()
        setupReviewSlideScrollView(reviewSlides: reviewSlides)
        
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
    
    func getHelperStory() {
        HelperStoryService.shared.getHelperStory() { helperStory, statusCode in
            switch statusCode {
            case 200:
                self.helperStory = helperStory
                self.dataList = self.helperStory?.data
                self.scrollView.reloadInputViews()
                break;
            default:
                //self.simpleAlert(title: "통신 실패", message: "네트워크 상태로 확인하세요.")
                break;
            }
        }
    }
    
    @objc func tappedconcern1(_ gesture: UITapGestureRecognizer) {
        let storyboard: UIStoryboard = UIStoryboard(name: "AskerList", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "AskerListNavi")
        present(viewcontroller, animated: true)
    }
    
    @objc func autoScroll() {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + scrollView.frame.width, y: 0), animated: true)
        self.AskerScrollView.setContentOffset(CGPoint(x: self.AskerScrollView.contentOffset.x + AskerScrollView.frame.width, y: 0), animated: true)
    }

    func createSlides() -> [Slide] {
        var appendSlide = Slide()
        var num = 0
        
        for data in dataList ?? [HelperStoryData]() {
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.name.text = data.nickname
            slide.category.text = data.categoryName
            slide.content.text = data.content
            slideList.append(slide)
            if(num == 0){
                appendSlide = slide
                num = num + 1
            }
        }
        slideList.append(appendSlide)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slideList.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slideList.count {
            slideList[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slideList[i])
        }
        
        return slideList
        
        
        /*let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.name.text = "앱잼파이팅 헬퍼님"
        slide1.category.text = "연애"
        slide1.content.text = "- 20대에 억단위를 벌어본 경험\n- 3년간 투병생활\n- 20년간 어머니를 병간호한 경험"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.name.text = "헬퍼2"
        slide2.category.text = "진로"
        slide2.content.text = "22222222222"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.name.text = "헬퍼3"
        slide3.category.text = "심리"
        slide3.content.text = "333333333333"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.name.text = "헬퍼4"
        slide4.category.text = "인간관계"
        slide4.content.text = "4444444444444"
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.name.text = "헬퍼5"
        slide5.category.text = "일상"
        slide5.content.text = "55555555555"
        
        let slide6:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide6.name.text = "앱잼파이팅 헬퍼님"
        slide6.category.text = "연애"
        slide6.content.text = "- 20대에 억단위를 벌어본 경험\n- 3년간 투병생활\n- 20년간 어머니를 병간호한 경험"
 
        return [slide1, slide2, slide3, slide4, slide5, slide6]*/
    }
    
    func setupSlideScrollView(slides : [Slide]) {
       
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
       
        ReviewSlide1.category.text = "일상"
        ReviewSlide1.content.text = "11질문자들의 후기입니다.질문자들의 후기입니다.질문자들의 후기입니다.질문자들의 후기입니다."
        ReviewSlide1.asker.text = "- 기계과 전공으로 진로에 대해 고민 중인 윌슨님-"
        
        let ReviewSlide2:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide2.category.text = "연애"
        ReviewSlide2.content.text = "22큰 기대하지 않고 진로에 대한 고민을 신청했는데 답변자님이 정말 진지하게 전문적으로 상담해주셔서 너무 도움이 되었습니다. 감사합니다. ”"
        ReviewSlide2.asker.text = "- 컴퓨터공학과 전공으로 연애에 대해 고민 중인 릴라님-"
        
        let ReviewSlide3:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide3.category.text = "진로"
        ReviewSlide3.content.text = "33“ 안녕안녕안녕앙년아녀안연연여낭녀아연아녀 ”"
        ReviewSlide3.asker.text = "- 화학과 전공으로 진로에 대해 고민 중인 릴라님-"
        
        let ReviewSlide4:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide4.category.text = "진로"
        ReviewSlide4.content.text = "44“ 큰 기대하지 않고 진로에 대한 고민을 신청했는데 답변자님이 정말 진지하게 전문적으로 상담해주셔서 너무 도움이 되었습니다. 감사합니다. ”"
        ReviewSlide4.asker.text = "- 수학과 전공으로 진로에 대해 고민 중인 릴라님-"
        
        let ReviewSlide5:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide5.category.text = "진로"
        ReviewSlide5.content.text = "55“ ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅂㅈㄷㄱㅂㅈ더ㅣ;ㅓ만어라ㅣㅓㅂ쟏;버ㅓㅏ. ”"
        ReviewSlide5.asker.text = "- 중문과 전공으로 진로에 대해 고민 중인 릴라님-"
        
        let ReviewSlide6:ReviewSlide = Bundle.main.loadNibNamed("ReviewSlide", owner: self, options: nil)?.first as! ReviewSlide
        
        ReviewSlide6.category.text = "일상"
        ReviewSlide6.content.text = "11질문자들의 후기입니다.질문자들의 후기입니다.질문자들의 후기입니다.질문자들의 후기입니다."
        ReviewSlide6.asker.text = "- 기계과 전공으로 진로에 대해 고민 중인 윌슨님-"
        
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
