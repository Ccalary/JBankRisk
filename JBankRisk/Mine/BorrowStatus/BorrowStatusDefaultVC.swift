//
//  BorrowStatusDefaultVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowStatusDefaultVC: UIViewController {
    
    enum DefaultType {
        case applyStatus1
        case applyStatus2
    }
    
    var defaultType: DefaultType = .applyStatus1
    //nav 标题
    var defaultTitle = ""
    
    var defaultView: BorrowDefaultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch defaultType {
        case .applyStatus1:
            defaultView =  BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.applyStatus1)
        case .applyStatus2:
            defaultView =  BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.applyStatus2)
        }
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        navHoldView.navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
    }
    
    //基本UI
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.title = defaultTitle
        self.setNavUI()
        
        self.view.addSubview(defaultView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
    }
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: NavigationView = {
        let holdView = NavigationView()
        return holdView
    }()
//    /*********/
//    private lazy var defaultView: BorrowDefaultView = {
//        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.applyStatus1)
//        return holdView
//    }()
}
