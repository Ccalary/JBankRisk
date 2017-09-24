//
//  ContractViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/7.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  合同

import UIKit
import SwiftyJSON

private let cellID = "cellID"

class ContractViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum ViewType {
        case sign //签署
        case search //查看
    }
    
    var viewType: ViewType = .sign
    
    //产品id
    var orderId = ""
    
    var dataArray: [JSON] = []
    
    var signedNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        switch viewType {
        case .search:
            self.title = "合同详情"
        case .sign:
            self.title = "签署合同"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestListData()
    }
    
    func setupUI(){
        self.navigationItem.title = "签署合同"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
        }
        
        //刷新
        self.aTableView.addPullRefreshHandler({[weak self] _ in
            self?.requestListData()
            self?.aTableView.stopPullRefreshEver()
        })
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(ContractTableViewCell.self, forCellReuseIdentifier: cellID)
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ContractTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.leftTextLabel.text = dataArray[indexPath.row]["name"].stringValue
        
        switch self.viewType {
        case .sign:
            //0- 未签署 1-已签署
            cell.status = dataArray[indexPath.row]["jstatus"].stringValue
            cell.arrowImageView.isHidden = true
        case .search:
            cell.arrowImageView.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.viewType {
        case .sign:
            //0- 未签署 1-已签署
            if dataArray[indexPath.row]["jstatus"].stringValue == "0" {
                self.signContract(flag: dataArray[indexPath.row]["flag"].stringValue)
            }else {
                self.seeContract(contractId: dataArray[indexPath.row]["contractId"].stringValue)
            }

            
        case .search:
            self.seeContract(contractId: dataArray[indexPath.row]["contractId"].stringValue)
        }
    }

    //请求数据
    func requestListData(){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        
        NetConnect.other_contract_list(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
            self.dataArray.removeAll()
            self.dataArray = json["backList"].arrayValue
            
            //判断签署情况
            if self.viewType == .sign {
                self.signedNum = 0
                for dic in self.dataArray {
                    //0- 未签署  1- 已签署
                    if dic["jstatus"].stringValue == "1" {
                        self.signedNum += 1
                    }
                }
                //是否签完合同
                if self.signedNum == self.dataArray.count {
                    UserHelper.setContract(isSigned: true)
                }else {
                    UserHelper.setContract(isSigned: false)
                }
            }
            self.aTableView.reloadData()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //合同签约
    func signContract(flag: String){
        
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        params["flag"] = flag
        
        NetConnect.other_contract_sign(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                YHTSdk.setToken(json["backInfo"]["TOKEN"].stringValue)
                let YHTVC = YHTContractContentViewController.instance(withContractID: json["backInfo"]["contractId"].numberValue)
                self.navigationController?.pushViewController(YHTVC!, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })

    }
    
    //合同查看
    func seeContract(contractId: String){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        params["contractId"] = contractId
        
        NetConnect.other_contract_search(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                YHTSdk.setToken(json["backInfo"]["token"].stringValue)
                let YHTVC = YHTContractContentViewController.instance(withContractID: json["backInfo"]["contractId"].numberValue)
                self.navigationController?.pushViewController(YHTVC!, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
}
