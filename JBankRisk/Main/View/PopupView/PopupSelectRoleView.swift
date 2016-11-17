//
//  PopupSelectRoleView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/14.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupSelectRoleView: UIView, iCarouselDelegate, iCarouselDataSource  {
    
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupUI()
    }
    
    ///便利构造 默认frame全屏
    convenience init(currentIndex: Int) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.init(frame: frame)
        self.carousel.currentItemIndex = currentIndex
        self.carouselCurrentItemIndexDidChange(self.carousel)
        
        switch currentIndex {
        case 0:
            studentView.selectBtn.setBackgroundImage(UIImage(named:"btn_selected_red_150x40"), for: .normal)
        case 1:
            workerView.selectBtn.setBackgroundImage(UIImage(named:"btn_selected_red_150x40"), for: .normal)
        case 2:
            freedomView.selectBtn.setBackgroundImage(UIImage(named:"btn_selected_red_150x40"), for: .normal)
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //基本UI
    func setupUI(){
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(carousel)
        self.addSubview(closeBtn)
        
        carousel.snp.makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(22*UIRate)
            make.bottom.equalTo(self.snp.bottom).offset(-110*UIRate)
            make.centerX.equalTo(self)
        }
    }
    
    private lazy var carousel: iCarousel = {
       
        let carousel = iCarousel()
        carousel.type = .linear
        carousel.delegate = self
        carousel.dataSource = self

        return carousel
    }()
    
    ///关闭按钮
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_close_22x22"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var workerView: PopupRoleView = {
         let popView = PopupRoleView(roleType: .worker)
        return popView
    }()
    
    private lazy var studentView: PopupRoleView = {
        let popView = PopupRoleView(roleType: .student)
        return popView
    }()

    private lazy var freedomView: PopupRoleView = {
        let popView = PopupRoleView(roleType: .freedom)
        return popView
    }()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: PopupRoleView
        
        switch index {
        case 0:
            itemView = studentView
            studentView.onClickSelectBtn = { role in
                //延时执行
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                    if let onClickSelect = self.onClickSelect {
                        onClickSelect(role)
                    }
                }
            }
        case 1:
            itemView = workerView
            workerView.onClickSelectBtn = { role in
                //延时执行
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                    if let onClickSelect = self.onClickSelect {
                        onClickSelect(role)
                    }
                }
            }
            
        default:
            itemView = freedomView
            freedomView.onClickSelectBtn = { role in
                //延时执行
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                    if let onClickSelect = self.onClickSelect {
                        onClickSelect(role)
                    }
                }
            }
        }
        
        return itemView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
    
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .spacing {
            return value * 1.1
        }
        return value
    }

    //MARK: - Action
    var onClickCloseBtn: (()->())?
    
    var onClickSelect: ((_ viewType: RoleType)->())?
    
    //关闭按钮
    func closeBtnAction(){
        
        if let onClickCloseBtn = onClickCloseBtn {
             onClickCloseBtn()
        }
    }
    
}
