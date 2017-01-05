
//
//  RepayViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

private let cellIdentity = "cellID"
private let kAppURLScheme = "riskPayUrlSchemes"
class RepayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //支付方式
    var selectWay = "" {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    var selectInfo: [Dictionary<String,Any>] = []
    
    var selectArray = [0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.title = "还款"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "账单", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("00b2ff")
        
        self.initHeader()
    }

    //header
    func initHeader(){
        
        let headerHoldView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 196*UIRate))
        headerHoldView.backgroundColor = defaultBackgroundColor
        let footerHoldView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 64*UIRate, width: SCREEN_WIDTH, height: 64*UIRate))
        
        self.view.addSubview(aTableView)
        self.view.addSubview(footerHoldView)
        self.aTableView.tableHeaderView = headerHoldView
        self.aTableView.tableFooterView = divideLine2
        
        headerHoldView.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(moneyLabel)
        headerHoldView.addSubview(nameTextLabel)
        headerHoldView.addSubview(divideLine1)

        footerHoldView.addSubview(nextStepBtn)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 64*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(40*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalTextLabel.snp.bottom).offset(23*UIRate)
        }
        
        nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(headerHoldView.snp.bottom).offset(-20*UIRate)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(0)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-10*UIRate)
        }
    }
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image3_375x156")
        return imageView
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "本次需还款金额(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("a1a1a1")
        label.text = "选择支付方式"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        
        button.setTitle("下一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(RepayTableViewCell.self, forCellReuseIdentifier:cellIdentity)
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as! RepayTableViewCell
        cell.rightArrowImageView.isHidden = true
        cell.selectImageView.isHidden = false
        
        if selectArray[indexPath.row] == 1 {
            cell.selectImageView.image = UIImage(named: "repay_selected_circle_20x20")
        }else {
            cell.selectImageView.image = UIImage(named: "repay_unselect_circle_20x20")
        }
        
        switch indexPath.row {
        case 0:
            cell.topImageView.image = UIImage(named: "r_wechat_25x25")
            cell.leftTextLabel.text = "微信支付"
        case 1:
            cell.topImageView.image = UIImage(named: "r_alipay_25x25")
            cell.leftTextLabel.text = "支付宝支付"
        case 2:
            cell.topImageView.image = UIImage(named: "r_ebank_25x25")
            cell.leftTextLabel.text = "网银支付"
            cell.rightArrowImageView.isHidden = false
            cell.selectImageView.isHidden = true
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectArray = selectArray.map{$0 * 0}
        selectArray[indexPath.row] = 1
        
        switch indexPath.row {
        case 0:
          selectWay = "wx"
        case 1:
           selectWay = "alipay"
        case 2:
            selectWay = ""
            let popView = PopupEbankRepayView()
            let popupController = CNPPopupController(contents: [popView])!
            popupController.present(animated: true)
            
            popView.onClickSure = {_ in
                popupController.dismiss(animated:true)
            }
            
            popView.onClickCopy = {_ in
                popupController.dismiss(animated:true)
                self.showHint(in: self.view, hint: "帐号已复制到剪切板")
            }
        default:
            break
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
    //MARK: - Action
    func rightNavigationBarBtnAction(){
        
    }
    
    func nextStepBtnAction(){
        repayRequest()
    }
    
    //MARK:请求支付接口
    func repayRequest(){
        guard !selectWay.isEmpty else {
            self.showHint(in: self.view, hint: "请选择支付方式")
            return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        var params = NetConnect.getBaseRequestParams()
        params["channel"] = "3"
        params["payChannel"] = selectWay
        params["client_ip"] =  toolsGetIPAddresses()
        params["repaymentList"] = toolsChangeToJson(info: self.selectInfo)
        
        NetConnect.pc_repay_request(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            let charge = json["charge"].dictionaryObject
            
            Pingpp.createPayment(charge as NSObject!, viewController: self, appURLScheme: kAppURLScheme, withCompletion: { (result, error) in
                if result == "success" {
                    //支付成功
                    PrintLog(result)
                }else {
                    //支付失败或取消
                    PrintLog(error?.code.rawValue)
                    PrintLog(error?.getMsg())
                }
            })
            
//            Pingpp.createPayment(charge as NSObject!, appURLScheme: kAppURLScheme) { (result, error) -> Void in
//                
//                PrintLog(result)
//                
//                if error != nil {
//                    PrintLog(error?.code.rawValue)
//                    PrintLog(error?.getMsg())
//                }
//            }
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
 }
    //MARK:请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["channel"] = "3"
        params["repaymentList"] = toolsChangeToJson(info: self.selectInfo)
        
        NetConnect.pc_repay_amount(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.moneyLabel.text = toolsChangeMoneyStyle(amount: json["showMoney"].doubleValue)
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
   }
    
}
