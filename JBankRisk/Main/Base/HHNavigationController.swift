//
//  HHNavigationController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/9/27.
//  Copyright © 2016年 chh. All rights reserved.
//

import UIKit

class HHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override class func initialize() {
        super.initialize()
        let navBar = UINavigationBar.appearance()
        //设置navigationBar的背景色
        navBar.barTintColor = UIColor.white
        
        //设置左右bar的颜色
        navBar.tintColor = UIColorHex("666666")
        navBar.titleTextAttributes = [NSFontAttributeName: UIFontSize(size: 18), NSForegroundColorAttributeName:UIColorHex("666666")]
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0{
            //push时隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            //backBarButtonItem 是带有字和返回箭头的样式
            //左侧返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBack(){
        popViewController(animated: true)
    }
}
