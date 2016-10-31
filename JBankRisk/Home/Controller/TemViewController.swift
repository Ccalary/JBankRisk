//
//  TemViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/10.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit


class TemViewController: UIViewController, iCarouselDelegate, iCarouselDataSource {
    
    var carousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        carousel = iCarousel(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 400))
        carousel.type = .linear
        carousel.delegate = self
        carousel.dataSource = self
        
        self.view.addSubview(carousel)
        
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: UIView
        
        switch index {
        case 0:
            itemView = PopupRoleView(roleType: .worker)
            
//            itemView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            popupView.center = itemView.center
//            itemView.addSubview(popupView)
        case 1:
            itemView = PopupRoleView(roleType: .student)
            
//            itemView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            popupView.center = itemView.center
//            itemView.addSubview(popupView)
        case 2:
            itemView = PopupRoleView(roleType: .freedom)
            
//            itemView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            popupView.center = itemView.center
//            itemView.addSubview(popupView)
        default:
            let popupView = PopupRoleView(roleType: .worker)
            
            itemView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            popupView.center = itemView.center
            itemView.addSubview(popupView)
        }
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .spacing {
            return value * 1.1
        }
        return value
    }
    
}
