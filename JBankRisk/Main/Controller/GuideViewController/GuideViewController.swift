//
//  GuideViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/27.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
protocol GuideViewDelegate: class {
    func enterTheApp()
}

class GuideViewController: UIViewController, UIScrollViewDelegate{

    weak var delegate: GuideViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(mScrollView)
        self.view.addSubview(pageControl)
        self.mScrollView.addSubview(imageView1)
        self.mScrollView.addSubview(imageView2)
        self.mScrollView.addSubview(imageView3)
        self.mScrollView.addSubview(holdView)
        self.holdView.addSubview(imageView4)
        self.holdView.addSubview(nextStepBtn)
        
        mScrollView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.center.equalTo(self.view)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(110*UIRate)
            make.height.equalTo(30*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-20*UIRate)
        }

        imageView1.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }

        imageView2.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(SCREEN_WIDTH)
            make.top.equalTo(0)
        }
        
        imageView3.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(2*SCREEN_WIDTH)
            make.top.equalTo(0)
        }
        
        holdView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(3*SCREEN_WIDTH)
            make.top.equalTo(0)
        }
        
        imageView4.snp.makeConstraints { (make) in
            make.size.equalTo(holdView)
            make.center.equalTo(holdView)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(110*UIRate)
            make.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView)
            make.bottom.equalTo(-20*UIRate)
        }
    }
    
    private lazy var mScrollView: UIScrollView = {
        let holdView = UIScrollView()
        holdView.delegate = self
        holdView.isPagingEnabled = true
        holdView.bounces = false
        holdView.showsHorizontalScrollIndicator = false
        holdView.backgroundColor = UIColor.white
        holdView.contentSize = CGSize(width: SCREEN_WIDTH * 4, height: SCREEN_HEIGHT)
        return holdView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColorHex("f5f5f5")
        return pageControl
    }()
    
    //图片
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "guide_image1")
        return imageView
    }()
    
    //图片
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "guide_image2")
        return imageView
    }()
    
    //图片
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "guide_image3")
        return imageView
    }()
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "guide_image4")
        return imageView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "guide_enter_110x30"), for: .normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
        pageControl.currentPage = page
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > SCREEN_WIDTH * 2.5 {
            pageControl.isHidden = true
        }else {
            pageControl.isHidden = false
        }
    }
    
    func nextStepBtnAction(){
        if delegate != nil {
            self.delegate?.enterTheApp()
        }
    }
}
