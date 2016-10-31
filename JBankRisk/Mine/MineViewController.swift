//
//  MineViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/9.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class MineViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置不自动下调64
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;

        //启动滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //加载UI
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }


    func setupUI() {
        
        self.view.addSubview(topImageView)
        self.view.addSubview(sayHelloTextLabel)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(200*UIRate)
            make.top.equalTo(self.view)
        }
        
        sayHelloTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(topImageView.snp.bottom).offset(-20*UIRate)
            make.centerX.equalTo(self.view)
        }
    }
    
    var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        return imageView
    }()
    
    var sayHelloTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFontSize(size: 15*UIRate)
        textLabel.textAlignment = .center
        textLabel.text = "您好： 曹先生"
        return textLabel
    }()
    
}
