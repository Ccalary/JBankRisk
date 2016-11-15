//
//  HomeViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  首页

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire

let homeCellID = "HomeTableViewCell"

class HomeViewController: UIViewController, UIGestureRecognizerDelegate{
    
    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    var bannerView: CyclePictureView! //图片轮播
    var imageArray:[String]? = [""] //储存所有照片

    var responseDic = [String:Any]()
    //cell数据
    var cellDataArray: [Dictionary<String,String>] = [["":""],["":""],["":""]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        //启动滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        //监听网络
        self.listeningNetStatus()
        
        self.requestHomeData()
        
        setup()
        initBannerImage()
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
    
    //基本设置
    func setup(){
        self.view.addSubview(aTableView)
        aTableView.snp.makeConstraints { (mark) in
            mark.width.equalTo(self.view)
            mark.height.equalTo(SCREEN_HEIGHT - 49)
            mark.top.equalTo(0)
        }
        
        self.aTableView.addPullRefreshHandler({ _ in
            self.requestHomeData()
             self.aTableView.stopPullRefreshEver()
        })
    }
    
   private lazy var aTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellID)
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {tableView.separatorInset = .zero
         }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
    }()
    
    //MARK: - 初始化banner轮播图
    func initBannerImage(){
        
        //图片轮播
        bannerView = CyclePictureView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 220*UIRate), imageArray:imageArray!)
//        bannerView.delegate = self
        self.aTableView.tableHeaderView = bannerView
    }
    
    
    func requestHomeData(){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId() ?? ""
        NetConnect.bm_home_url(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                self.responseDic = json.dictionaryValue
                self.imageArray = json["bannnerList"].arrayObject as! [String]?
                self.cellDataArray = json["list"].arrayObject as! [Dictionary<String, String>]
                self.showData()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func showData(){
        self.initBannerImage()
        self.aTableView.reloadData()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource,CyclePictureViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! HomeTableViewCell
    
        cell.topTextLabel.text = cellDataArray[indexPath.row]["show1"]
        cell.bottomTextLabel.text = cellDataArray[indexPath.row]["show2"]
        switch indexPath.row {
        case 0:
            cell.leftImageView.image = UIImage(named: "home_loan_icon_50x50")
            cell.rightTextLabel.text = "我要借款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 1:
            cell.leftImageView.image = UIImage(named: "home_progress_icon_50x50")
            cell.rightTextLabel.text = "进度查询"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 2:
            cell.leftImageView.image = UIImage(named: "home_repayment_icon_50x50")
            cell.rightTextLabel.text = "我要还款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let popupView =  PopupSelectRoleView(currentIndex: -1)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.theme.presentationStyle = .slideInFromRight
            popupController.theme.dismissesOppositeDirection = false
            popupController.present(animated: true)
            popupView.onClickCloseBtn = { _ in
               popupController.dismiss(animated: true)
            }
            popupView.onClickSelect = { role in
                popupController.dismiss(animated: true)
                UserHelper.setUserRole(role: role.rawValue)
                let borrowMoneyVC = BorrowMoneyViewController()
                borrowMoneyVC.roleType = role
                self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
            }
        case 1:
            let repayDetailVC = NeedRepayViewController()
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
//
//            let phoneCallView = PopupAreaView()
//            let popupController = CNPPopupController(contents: [phoneCallView])!
//            popupController.present(animated: true)
//            phoneCallView.onClickSelect = {_ in
//                popupController.dismiss(animated: true)
//            }
            break
        case 2:
            let registerVC = RepayPeriodDetailVC()
            self.navigationController?.pushViewController(registerVC, animated: true)
            break
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
    
    //MARK: - CyclePictureViewDelegate的方法(点击跳转)
    func cyclePictureSkip(To index: Int) {
//        let bannerUrlVC = BaseWebViewController()
//        bannerUrlVC.requestUrl = self.urlArray?[index] as? String
//        self.navigationController?.pushViewController(bannerUrlVC, animated: false
//        )
    }
    
    //网络状态
    func listeningNetStatus(){
        self.manager?.listener = { status in
            
            switch status {
            case .unknown:
                self.showHintInKeywindow(hint: "未知网络连接")
            case .notReachable:
                self.showHintInKeywindow(hint: "无网络连接")
            case .reachable(.ethernetOrWiFi):
                self.showHintInKeywindow(hint: "WiFi连接")
            case .reachable(.wwan):
                self.showHintInKeywindow(hint: "数据网络连接")
            }
        }
        self.manager?.startListening()
    }

}
