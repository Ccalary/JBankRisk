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

    var orderId = ""
    
    //支付金额
    private var cancelMoney: Double = 0.00
    private var repaymentId = ""
    
    private var selectInfo: [Dictionary<String,Any>] = []

    
    private var dataArray:[JSON] = []{
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI(){
        
        self.navigationItem.title = "撤销订单"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"nav_notice_20x20"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("666666")
        
        self.view.addSubview(holdView)
        self.holdView.addSubview(aTableView)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(360*UIRate)
            make.height.equalTo(340*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(10)
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
        holdView.isUserInteractionEnabled = true
        return holdView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.register(CancelOrderTableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray.count <= 4) ? dataArray.count : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CancelOrderTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        //填充数据
        cell.cellWithData(self.dataArray[indexPath.row], at: indexPath.row, andMoney: self.cancelMoney)
        
        //支付
        cell.onClickPay = {[weak self] _ in
            self?.gotoPay()
        }
        
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

    //支付
    func gotoPay(){
        var dic = [String:Any]()
        dic["orderId"] = self.orderId
        dic["repayment_id"] = self.repaymentId
        self.selectInfo.removeAll()
        self.selectInfo.append(dic)
        
        let repayVC = RepayViewController()
        repayVC.selectInfo =  self.selectInfo 
        //还款方式， 0 正常还款 1七日内还款 2账单清算
        repayVC.flag = 0
        self.navigationController?.pushViewController(repayVC, animated: true)
    }
    
    //MARK: - 数据请求
    func requestData(){
        
        showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        
        NetConnect.pc_cancel_order(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.cancelMoney = json["penaltyMoney"].doubleValue
            self.repaymentId = json["repayment_id"].stringValue
            self.dataArray = json["backList"].arrayValue
           
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }
    
}
