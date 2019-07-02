//
//  AskerMainViewController.swift
//  Willson
//
//  Created by 박지수 on 01/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerMainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView! //헬퍼들의 이야기 좌우스크롤뷰
    @IBOutlet weak var AskerScrollView: UIScrollView! //질문자들의 후기 좌우스크롤뷰
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ReviewPageControl: UIPageControl!
    
    var slides:[Slide] = [];
    var reviewSlides:[ReviewSlide] = [];
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //헬퍼
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count - 1
        pageControl.currentPage = 0
        scrollView.bringSubviewToFront(pageControl)
        
        
        //질문자
        AskerScrollView.delegate = self
        
        reviewSlides = createReviewSlides()
        setupReviewSlideScrollView(reviewSlides: reviewSlides)
        
        ReviewPageControl.numberOfPages = reviewSlides.count - 1
        ReviewPageControl.currentPage = 0
        AskerScrollView.bringSubviewToFront(ReviewPageControl)
    }
    
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
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
        
        return [slide1, slide2, slide3, slide4, slide5, slide6]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        if(percentOffset.x > 0 && percentOffset.x <= 0.2) {
            slides[0].mask?.transform = CGAffineTransform(scaleX: (0.2-percentOffset.x)/0.2, y: (0.2-percentOffset.x)/0.2)
            slides[1].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.2, y: percentOffset.x/0.2)
            
        } else if(percentOffset.x > 0.2 && percentOffset.x <= 0.4) {
            slides[1].mask?.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.2, y: (0.4-percentOffset.x)/0.2)
            slides[2].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
            
        } else if(percentOffset.x > 0.4 && percentOffset.x <= 0.6) {
            slides[2].mask?.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.2, y: (0.6-percentOffset.x)/0.2)
            slides[3].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
            
        } else if(percentOffset.x > 0.6 && percentOffset.x <= 0.8) {
            slides[3].mask?.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.2, y: (0.8-percentOffset.x)/0.2)
            slides[4].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
        } else if(percentOffset.x > 0.8 && percentOffset.x <= 1) {
            pageControl.currentPage = 0
            slides[4].mask?.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
            slides[5].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
           
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
    
    func AskerScrollViewDidScroll(_ AskerScrollView: UIScrollView) {
        let pageIndex = round(AskerScrollView.contentOffset.x/view.frame.width)
        ReviewPageControl.currentPage = Int(pageIndex)
        
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
            ReviewPageControl.currentPage = 0
            reviewSlides[4].mask?.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
            reviewSlides[5].mask?.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
            
        } else if(percentOffset.x > 1) {
            let offset = CGPoint(x: 0, y: -AskerScrollView.adjustedContentInset.top)
            AskerScrollView.setContentOffset(offset, animated: false)
        }
    }
}
