//
//  BorrowStatusVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowStatusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.title = "借款状态"
        
        self.view.addSubview(statusView)
        self.view.addSubview(infoView)
        
        statusView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(280*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

        infoView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.statusView.snp.bottom)
        }
        
    }
    
    private lazy var statusView: BorrowStatusView = {
        let holdView = BorrowStatusView()
        return holdView
    }()
    
    private lazy var infoView: BorrowInfoView = {
        let holdView = BorrowInfoView(viewType: BorrowInfoView.BorrowInfoType.fiveData)
        return holdView
    }()
    

    

}
