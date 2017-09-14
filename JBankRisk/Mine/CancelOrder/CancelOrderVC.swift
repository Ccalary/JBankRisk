//
//  CancelOrderVC.swift
//  JBankRisk
//
//  Created by chh on 2017/9/14.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

private let cellID = "cellID"
class CancelOrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI(){
        
        self.navigationItem.title = "撤销订单"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"nav_notice_20x20"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("666666")
        
        self.view.addSubview(holdView)
        self.holdView.addSubview(aTableView)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(360*UIRate)
            make.height.equalTo(340*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64 + 10)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.left.equalTo(holdView).offset(10)
            make.right.equalTo(holdView).offset(-10)
            make.height.equalTo(320*UIRate)
            make.top.equalTo(10*UIRate)
        }
    }
    
    private lazy var holdView: UIImageView = {
        let holdView = UIImageView()
        holdView.image = UIImage(named: "c_bg_360x330");
        return holdView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(CancelOrderTableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CancelOrderTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*UIRate
    }
    
    //MARK: - action
    func rightNavigationBarBtnAction(){
        //跳转到注意事项界面
        self.navigationController?.pushViewController(CancelOrderNoticeVC(), animated: true)
    }

    
    //MARK: - 个人中心数据请求
    func requestHomeData(){
        
        let params = NetConnect.getBaseRequestParams()
        
        NetConnect.pc_home_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }

}
