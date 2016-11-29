//
//  MineViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/9.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class MineViewController: UIViewController, UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, StatusButtonClickDelegate,MineTioViewClickDelegate{

    var topHeight:CGFloat = 0//总高度
    
    var topImageHeight = 220*UIRate//头部
    var tipViewHeight = 25*UIRate//提示条
    var repayViewHeight = 70*UIRate//还款栏
    
    //产品id
    var orderId = ""
    
    //var 还款状态
    var repayStatus = ""
    
    //topView高度改变
    var mineTopConstrain: Constraint!
    
    var headerView:MineHeaderView!
    var footerView:MineFooterView!
    
    //摇摆动画
    var momAnimation:CABasicAnimation!
    
    var messageIsHaveData = false
    //借款状态码
    var moneyStatus = ""
    
    //未读信息个数
    var messageCount = 0 {
        didSet{
            if messageCount > 0 {
                self.mineTopView.messageRedDot.isHidden = false
                self.shakeAnimation()//添加晃动动画
            }else {
                self.mineTopView.messageRedDot.isHidden = true
                //移除晃动动画
                self.mineTopView.messageBtn.layer.removeAllAnimations()
            }
        }
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestHomeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
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
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(aScrollView)
        
        self.aScrollView.addSubview(mineTopView)
        self.aScrollView.addSubview(aCollectionView)
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(667*UIRate - 49)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 667*UIRate - 49 + 1)
        
        self.aScrollView.addPullRefreshHandler({ [weak self] in
            self?.requestHomeData()
            self?.aScrollView.stopPullRefreshEver()
        })
        
        mineTopView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            self.mineTopConstrain = make.height.equalTo(topImageHeight).constraint
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        aCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(205*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(mineTopView.snp.bottom)
        }
    }
    
    private lazy var aScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    fileprivate lazy var mineTopView : MineTopView = {
        let topView = MineTopView()
        topView.delegate = self
        return topView
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 1.8*UIRate)/3, height: 75*UIRate)
        layout.minimumInteritemSpacing = 0.7*UIRate
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(MineCollectionViewCell.self, forCellWithReuseIdentifier: "mineCell")
        collectionView.register(MineHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(MineFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = defaultBackgroundColor
        
        return collectionView
    }()
    
    //MARK: - collectionView delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mineCell", for: indexPath) as! MineCollectionViewCell
        cell.backgroundColor = UIColor.white
        switch indexPath.row {
        case 0:
            cell.imageView.image = UIImage(named: "m_bm_record_28x28")
            cell.textLabel.text = "借款记录"
        case 1:
            cell.imageView.image = UIImage(named: "m_repay_bill_28x28")
            cell.textLabel.text = "还款账单"
        case 2:
            cell.imageView.image = UIImage(named: "m_repay_detail_28x28")
            cell.textLabel.text = "已还明细"
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { //借款记录
            let borrowRecordVC = BorrowRecordViewController()
            if moneyStatus == "" {//如果状态码没有，则加载缺省界面
                borrowRecordVC.isHaveData = false
            }else {
                borrowRecordVC.isHaveData = true
            }
            self.navigationController?.pushViewController(borrowRecordVC, animated: true)
        }else if indexPath.row == 1 { //还款账单
            let repayVC = RepayBillViewController()
            //5-还款中 0-已完结
            if moneyStatus == "5" || moneyStatus == "0" {
                repayVC.isHaveData = true
            }else {
                repayVC.isHaveData = false
            }
            self.navigationController?.pushViewController(repayVC, animated: true)
        }else if indexPath.row == 2 { //还款明细
            let repayDetailVC = RepayListViewController()
            if moneyStatus == "5" || moneyStatus == "0" {
                repayDetailVC.isHaveData = true
            }else {
                repayDetailVC.isHaveData = false
            }
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MineHeaderView
            headerView.delegate = self
            return headerView
            
        case UICollectionElementKindSectionFooter:
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! MineFooterView
            return footerView
        default:
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MineHeaderView
            headerView.delegate = self
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 70*UIRate)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 60*UIRate)
    }
    
   //MARK: - MineTioViewClickDelegate
    
    func mineTopViewOnClick(tag: Int) {
        switch tag {//消息
        case 10000:
            let messageVC = SysMessageViewController()
            messageVC.isHaveData = self.messageIsHaveData
            self.navigationController?.pushViewController(messageVC, animated: true)
        case 20000://设置
            let settingVC = SettingViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        case 30000://头像
            let settingVC = SettingViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        case 40000://逾期
            let repayDetailVC = RepayDetailViewController()
            repayDetailVC.orderId = self.orderId
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        default:
            break
        }
    }
    
    //MARK: - StatusButtonClickDelegate
    func clickStatusButtonAction(tag: Int){
        switch tag {
        case 10000://审核中
            if  headerView.tipImage1.isHidden {
                let statusVC = BorrowStatusDefaultVC()
                statusVC.defaultTitle = "审核中"
                 self.navigationController?.pushViewController(statusVC, animated: true)
            }else {
                let statusVC = BorrowStatusVC()
                self.navigationController?.pushViewController(statusVC, animated: true)
            }
           
        case 20000://待使用
            if  headerView.tipImage2.isHidden {
                let statusVC = BorrowStatusDefaultVC()
                statusVC.defaultTitle = "待使用"
                self.navigationController?.pushViewController(statusVC, animated: true)
            }else {
                let statusVC = BorrowStatusVC()
                self.navigationController?.pushViewController(statusVC, animated: true)
            }
           
        case 30000: //还款中
            if  headerView.tipImage3.isHidden {
                let statusVC = RepayingStatusVC()
                self.navigationController?.pushViewController(statusVC, animated: true)
            }else {
                let statusVC = BorrowStatusVC()
                self.navigationController?.pushViewController(statusVC, animated: true)
            }
          
        case 40000: //驳回－拒绝
            if  headerView.tipImage4.isHidden {
                let statusVC = BorrowStatusDefaultVC()
                statusVC.defaultTitle = "驳回/拒绝"
                self.navigationController?.pushViewController(statusVC, animated: true)
            }else {
                let statusVC = BorrowStatusVC()
                self.navigationController?.pushViewController(statusVC, animated: true)
            }
           
        default :
            break
        }
    }
    
    //MARK: - 个人中心数据请求
    func requestHomeData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        
        NetConnect.pc_home_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
         
            self.refreshUI(json: json["detail"])
            self.refreshNameUI(json: json["memberByInfo"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //问候语
    func refreshNameUI(json: JSON){
        
        let realName = json["realName"].stringValue
        let sex = json["sex"].stringValue
        var sexName = "先生"
        
        //0- 女  1-男
        if !realName.isEmpty && !sex.isEmpty{
              let firstName = realName.substring(to: realName.index(realName.startIndex, offsetBy: 1))
              if sex == "1"{
                sexName = "先生"
              }else if sex == "0"{
                sexName = "女士"
              }else {
                sexName = "**"
            }
            //用户名
            self.mineTopView.sayHelloTextLabel.text = "您好： \(firstName + sexName)"
            
        }else {
            
            //用户名
            self.mineTopView.sayHelloTextLabel.text = "您好： \(toolsChangePhoneNumStyle(mobile: UserHelper.getUserMobile()!))"
        }
    }
    
    
    func refreshUI(json:JSON){
        //重置高度
        topHeight = topImageHeight
        
        //头像
        UserHelper.setUserHeader(headerUrl: BASR_DEV_URL + json["head_img"].stringValue)
        mineTopView.headerImageView.kf_setImage(with: URL(string: UserHelper.getUserHeaderUrl() ?? ""), placeholder: UIImage(named: "m_heder_icon_90x90"), options: nil, progressBlock: nil, completionHandler: nil)
        
        //未读消息
        self.messageCount = json["size"].intValue
        
        //有逾期话术
        let message = json["message"].stringValue
        if  message.characters.count > 0 {
            self.mineTopView.overdueBtn.isHidden = false
            self.orderId = json["orderId"].stringValue
            self.mineTopView.tipsTextLabel.text = message
            self.mineTopView.tipsHoldViewContraint.update(offset: tipViewHeight)
            topHeight = topHeight + tipViewHeight
        }else {
            self.mineTopView.overdueBtn.isHidden = true
            self.mineTopView.tipsTextLabel.text = ""
            self.mineTopView.tipsHoldViewContraint.update(offset: 0)
            topHeight = topHeight + 0
        }
        
        if json["jstatus"].stringValue == "5" {//有还款明细
            
            self.mineTopView.moneyLabel.text = toolsChangeMoneyStyle(amount: json["MonthRefund"].doubleValue)
            
            //show1: 1-下期还款日   2-今日应还  3-最近还款日  4-逾期
            repayStatus = json["show1"].stringValue
            
            switch repayStatus {
            case "1":
                self.mineTopView.dateTextLabel.text = "下期还款日"
                self.mineTopView.dateLabel.text = toolsChangeDateStyle(toMMMonthDDDay: json["show2"].stringValue)
            case "2":
                self.mineTopView.dateTextLabel.text = "今日应还(元)"
                self.mineTopView.dateLabel.text = toolsChangeMoneyStyle(amount: json["show2"].doubleValue)
            case "3":
                self.mineTopView.dateTextLabel.text = "最近还款日"
                self.mineTopView.dateLabel.text = toolsChangeDateStyle(toMMMonthDDDay: json["show2"].stringValue)
            case "4":
                self.mineTopView.dateTextLabel.text = "逾期金额(元)"
                self.mineTopView.dateLabel.text = toolsChangeMoneyStyle(amount: json["show2"].doubleValue)
            default:
                self.mineTopView.dateTextLabel.text = "下期还款日"
               self.mineTopView.dateLabel.text = toolsChangeDateStyle(toMMMonthDDDay: json["nextMonthDay"].stringValue)
            }
            
            self.mineTopView.repayHoldViewContraint.update(offset: repayViewHeight)
            
            topHeight = topHeight + repayViewHeight
        }else {
            self.mineTopView.repayHoldViewContraint.update(offset: 0)
            topHeight = topHeight + 0
        }
        self.mineTopConstrain.update(offset: topHeight)
        
       moneyStatus = json["jstatus"].stringValue//个人中心借款状态
        if moneyStatus == "" || moneyStatus == "99"{//只要jstatus为空或为99-录入中，就没有单子产生
            messageIsHaveData = false
        }else {
            messageIsHaveData = true
        }
            headerView.tipImage1.isHidden = true
            headerView.tipImage2.isHidden = true
            headerView.tipImage3.isHidden = true
            headerView.tipImage4.isHidden = true
        //0- 订单完结 2－ 审核中 3-满额通过 4-等待放款，校验中 5-还款中 7－审核悲剧 8-重新上传服务单 9-补交材料 99-录入中
        switch moneyStatus {
         case "2": //审核中
            headerView.tipImage1.isHidden = false
        case "3","4","8": //待使用
           headerView.tipImage2.isHidden = false
        case "5"://还款中
           headerView.tipImage3.isHidden = false
        case "7","9"://审核悲剧
           headerView.tipImage4.isHidden = false
        default:
            break
        }
    }
}

extension MineViewController {
    
    //晃动动画
    func shakeAnimation(){
        self.mineTopView.messageBtn.layer.removeAllAnimations()//移除，避免多次重复添加
        self.momAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        self.momAnimation.fromValue = NSNumber(value: -0.1) //左幅度
        self.momAnimation.toValue = NSNumber(value: 0.1) //右幅度
        self.momAnimation.duration = 0.1
        self.momAnimation.repeatCount = HUGE //无限重复
        self.momAnimation.autoreverses = true //动画结束时执行逆动画
        self.momAnimation.isRemovedOnCompletion = false
        self.mineTopView.messageBtn.layer.add(momAnimation, forKey: "centerLayer")
    }
    
 }
