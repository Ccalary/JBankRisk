//
//  HHTabBarController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/9/27.
//  Copyright © 2016年 chh. All rights reserved.
//

import UIKit

class HHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabbar选中时字显示的颜色
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.red
        self.addChildrenViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    ///添加子控制器
    func addChildrenViewControllers(){
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home_normal_22x22", selectedImageName: "tabbar_home_press_22x22")
        addChildViewController(MineViewController(), title: "我的", imageName: "tabbar_mine_normal_22x22", selectedImageName: "tabbar_mine_press_22x22")
    }
    
    func addChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)//设置图片选中时的表现样式
        childController.title = title
        let nav = HHNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
