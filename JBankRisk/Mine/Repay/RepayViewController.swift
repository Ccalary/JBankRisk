
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

    //账单数据
    private var selectBillInfo: [JSON] = []
    
    //支付方式
    private var selectWay = ""
    //还款方式， 0 正常还款 1七日内还款 2账单清算
    var flag = 0
    
    var selectInfo: [Dictionary<String,Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(repayFailAndTryAgainAction), name: NSNotification.Name(rawValue: noticeRepayFailAndTryAgain), object: nil)
        
        setupUI()
        requestData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){        
        self.navigationItem.title = "还款"
        self.view.backgroundColor = defaultBackgroundColor
        self.initHeader()
    }

    //header
    func initHeader(){
        
        let headerHoldView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 156*UIRate + 45*UIRate))
        headerHoldView.backgroundColor = UIColor.white;
        let footerHoldView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 64*UIRate, width: SCREEN_WIDTH, height: 64*UIRate))
        
        self.view.addSubview(aTableView)
        self.view.addSubview(footerHoldView)
        self.aTableView.tableHeaderView = headerHoldView
        
        headerHoldView.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(moneyLabel)
        headerHoldView.addSubview(nameTextLabel)

        footerHoldView.addSubview(nextStepBtn)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight - 64*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
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
            make.top.equalTo(topImageView.snp.bottom)
            make.centerX.equalTo(headerHoldView)
            make.height.equalTo(45*UIRate)
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
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = ColorTextBlack
        label.text = "本次账单共0笔"
        return label
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        
        button.setTitle("确认还款", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier:cellIdentity)
        
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectBillInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! RepayDetailTableViewCell
        
        cell.textColorTheme = .needReDark
        cell.repayListCellWithData(dic: self.selectBillInfo[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var monthRepayStatus: RepayStatusType = .finish
        //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
        let repayStatus = self.selectBillInfo[indexPath.row]["is_pay"].stringValue
        if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
            monthRepayStatus = .finish
        }else  {//有逾期
            let penaltyDay = self.selectBillInfo[indexPath.row]["penalty_day"].intValue
                
            if penaltyDay > 0 {
                monthRepayStatus = .overdue
            }else {
                monthRepayStatus = .not
            }
        }
        let repayDetailVC = RepayPeriodDetailVC()
        repayDetailVC.repaymentId = self.selectBillInfo[indexPath.row]["repayment_id"].stringValue
        repayDetailVC.isFromRepayVC = true
        repayDetailVC.repayStatusType = monthRepayStatus //还款状态
        self.navigationController?.pushViewController(repayDetailVC, animated: true)
        
    }
    
    func nextStepBtnAction(){
        
        let popupView =  PopupRepayWayView()
        let popupController = CNPPopupController(contents: [popupView])!
       
        popupController.present(animated: true)
        popupView.onClickCloseBtn = { _ in
            popupController.dismiss(animated: true)
        }
        popupView.onClickSelect = {[unowned self] row in
            popupController.dismiss(animated: true)
            switch row {
            case 0:
                self.selectWay = "wx"
            case 1:
                self.selectWay = "alipay"
            default:
                self.selectWay = ""
        }
            //请求支付接口
            self.repayRequest()
      }
    }
    
    //NotificationCenter
    func repayFailAndTryAgainAction(){
        repayRequest()
    }
    
    //MARK:请求支付接口
    func repayRequest(){
        
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
                    let repayWay = self.selectWay == "wx" ? "微信支付" : "支付宝支付"
                    //需要id获取返回的信息
                    let repaymentId = self.selectInfo.first?["repayment_id"] ?? "" 
                    
                    let repayResultVC = RepayTipsViewController()
                    repayResultVC.repayResult = .success
                    
                    repayResultVC.repayInfo = (self.moneyLabel.text!, repayWay, repaymentId as! String , self.selectBillInfo.count)
                    self.navigationController?.pushViewController(repayResultVC, animated: true)
                }else {
                    //支付失败或取消
                    PrintLog(error?.code.rawValue)
                    PrintLog(error?.getMsg())
                    
                    let repayWay = self.selectWay == "wx" ? "微信支付" : "支付宝支付"
                
                    let repayResultVC = RepayTipsViewController()
                    repayResultVC.repayResult = .fail
                    repayResultVC.repayInfo = (self.moneyLabel.text!, repayWay, "",self.selectBillInfo.count)
                    self.navigationController?.pushViewController(repayResultVC, animated: true)
                }
            })
            
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
        params["flag"] = self.flag
        
        NetConnect.pc_repay_amount(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
           self.refreshUI(json)
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func refreshUI(_ json:JSON){
        self.moneyLabel.text = toolsChangeMoneyStyle(amount: json["showMoney"].doubleValue)
        self.selectBillInfo = json["payInfoList"].arrayValue
        
        //重新添加selectInfo，因为从账单清算过来不传selectInfo
        var selectInfoTemp: [Dictionary<String,Any>] = []
        
        selectInfoTemp = selectBillInfo.reduce(selectInfoTemp) { (selectInfoTemp, jsonObject) -> [Dictionary<String,Any>] in
            var dic = [String:Any]()
            dic["orderId"] = jsonObject["orderId"].stringValue
            dic["repayment_id"] = jsonObject["repayment_id"].stringValue
            
            var dicArray = selectInfoTemp
            dicArray.append(dic)
            return dicArray
        }
        selectInfo.removeAll()
        selectInfo = selectInfoTemp
       
        nameTextLabel.text = "本次账单共\(self.selectBillInfo.count)笔"
        self.aTableView.reloadData()
    }
    
}
