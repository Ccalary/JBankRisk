//
//  CyclePictureView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/10.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import Kingfisher

protocol CyclePictureViewDelegate{
    ///跳转到某个链接
    func cyclePictureSkip(To index: Int)
}

class CyclePictureView: UIView, UIScrollViewDelegate{

    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var curPage: Int = 0
    var curImageArray = [String]() //当前图片
    var imageArray = [String]()    //总的图片
    
    var viewWidth: CGFloat?            //view的宽度、高度
    var viewHeight: CGFloat?
    
    var delegate: CyclePictureViewDelegate?  // 代理
    
    var timer: Timer!
    
    var i: Int = 0
    
    ///true关闭计时器，false打开计时器
    var isDragging: Bool = false
    
    ///初始化传入frame与图片array即可
    init(frame: CGRect, imageArray: Array<String>) {
        super.init(frame: frame)
        
        viewWidth = self.frame.size.width
        viewHeight = self.frame.size.height
        
        self.imageArray = imageArray
        
        scrollView = UIScrollView(frame: frame)
        let contentWidth = imageArray.count < 2 ? viewWidth! : 3.0*viewWidth!
        scrollView.contentSize = CGSize(width: contentWidth, height: viewHeight!)
        scrollView.contentOffset = CGPoint(x: viewWidth!, y: 0)
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        //页码显示
        pageControl = UIPageControl(frame: CGRect(x: viewWidth! - 20*UIRate*CGFloat(imageArray.count), y: viewHeight! - 30*UIRate, width: 20*UIRate*CGFloat(imageArray.count), height: 20*UIRate))
        pageControl.numberOfPages = imageArray.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        //颜色设置
//        pageControl.currentPageIndicatorTintColor = UIColor(red: 1, green: 0.6, blue: 0.9, alpha: 1)
//        pageControl.pageIndicatorTintColor = UIColor.brown
        self.addSubview(pageControl)
        
        reloadImageData()
        //如果图片是一张的话则不显示页标，也不能进行轮播
        if imageArray.count < 2 {
            pageControl.isHidden = true
        }else{
            addTimer()
            pageControl.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //刷新图片
    func reloadImageData(){
        
        self.pageControl.currentPage = curPage
        
        var front = curPage - 1
        var last = curPage + 1
        
        if curPage == 0 {
            front = (self.imageArray.count) - 1
        }
        
        if curPage == (self.imageArray.count) - 1 {
            last = 0
        }
        
        if (curImageArray.count) > 0 {
            curImageArray.removeAll()
        }
        
        //当前图片数组添加图片
        curImageArray.append(self.imageArray[front])
        curImageArray.append(self.imageArray[curPage])
        curImageArray.append(self.imageArray[last])
        
        let subViews = self.scrollView.subviews
        if subViews.count > 0{
            for view in subViews {
                view.removeFromSuperview()
            }
        }
        
        //创建imageView
        for i in 0..<3 {
            let adImageView = UIImageView(frame: CGRect(x: CGFloat(i) * viewWidth!, y: 0, width: viewWidth!, height: viewHeight!))
            //一定要设置允许交互，要不然点击方法不响应
            adImageView.isUserInteractionEnabled = true
            let imageURL = URL(string: self.curImageArray[i] )
            adImageView.kf_setImage(with: imageURL as Resource?, placeholder: UIImage(named: "home_defaul_banner_375x220"), options: [], progressBlock: { (receivedSize, totalSize) in
                
                //                let progress = Double(receivedSize)/Double(totalSize)
                //
                //                let progressStr = NSString(format: "%.2f",progress*100.0) as String
                
                //                self.progressLabel.text = "下载进度：\(progressStr)%"
                
            }) { (image, error, cacheType, imageURL) in
                
            }
            
            //图片点击跳转链接
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTheImage))
            adImageView.addGestureRecognizer(tap)
            
            self.scrollView.addSubview(adImageView)
        }
        
        self.scrollView.contentOffset = CGPoint(x: viewWidth!, y: 0)
    }
    
    //MARK: - scrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= 2.0*SCREEN_WIDTH {
            
            curPage += 1
            
            if curPage == self.imageArray.count {
                curPage = 0
            }
            reloadImageData()
        }else if scrollView.contentOffset.x <= 0{
            
            curPage -= 1
            
            if curPage == -1 {
                curPage = (self.imageArray.count) - 1
            }
            reloadImageData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDragging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragging = false
    }
    
    //MARK: - 添加计时器
    func addTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    func nextImage(){
        
        if isDragging {
            return
        }
        self.scrollView.setContentOffset(CGPoint(x: 2.0 * viewWidth!,y: 0), animated: true)
        
    }
    
    // MARK: - Action:点击图片跳转
    func tapTheImage(){
        delegate?.cyclePictureSkip(To: curPage)
    }

}
