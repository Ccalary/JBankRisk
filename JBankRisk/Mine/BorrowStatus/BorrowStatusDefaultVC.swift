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
    
    //基本UI
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.title = defaultTitle
        
        self.view.addSubview(defaultView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
        }
    }
    
//    /*********/
//    private lazy var defaultView: BorrowDefaultView = {
//        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.applyStatus1)
//        return holdView
//    }()
}
