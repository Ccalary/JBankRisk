//
//  MineViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/9.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class MineViewController: UIViewController, UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var headerView:MineHeaderView!
    var footerView:MineFooterView!
    //未读信息个数
    var messageCount = 0
    
    
    
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
//        self.requestHomeData()
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


    func setupUI() {
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(topImageView)
        self.view.addSubview(messageBtn)
        self.messageBtn.addSubview(messageRedDot)
        self.view.addSubview(settingBtn)
        self.view.addSubview(headerImageView)
        self.view.addSubview(sayHelloTextLabel)
        
        /*****************/
        self.view.addSubview(tipsHoldView)
        self.tipsHoldView.addSubview(tipsTextLabel)
        
        /*************/
        self.view.addSubview(repayHoldView)
        self.repayHoldView.addSubview(repayDivideLine)
        self.repayHoldView.addSubview(repayDivideLine2)
        self.repayHoldView.addSubview(repayVerDivideLine)
        self.repayHoldView.addSubview(moneyLabel)
        self.repayHoldView.addSubview(moneyTextLabel)
        self.repayHoldView.addSubview(dateLabel)
        self.repayHoldView.addSubview(dateTextLabel)
        self.repayHoldView.addSubview(reBottomHoldView)
        
    
        /************/
        self.view.addSubview(aCollectionView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(220*UIRate)
            make.top.equalTo(self.view)
        }
        
        messageBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.left.equalTo(10*UIRate)
            make.top.equalTo(30*UIRate)
        }
        
        messageRedDot.snp.makeConstraints { (make) in
            make.width.height.equalTo(6*UIRate)
            make.centerX.equalTo(6.5*UIRate)
            make.centerY.equalTo(-6.5*UIRate)
        }

        settingBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.right.equalTo(topImageView.snp.right).offset(-10*UIRate)
            make.top.equalTo(30*UIRate)
        }
        
        headerImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(90*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(65*UIRate)
        }
        
        sayHelloTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(topImageView.snp.bottom).offset(-30*UIRate)
            make.centerX.equalTo(self.view)
        }
        
        /********/
        tipsHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(25*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        tipsTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(tipsHoldView)
        }

        /*********/

        repayHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(70*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom).offset(25*UIRate)
        }

        repayDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(60*UIRate)
        }

        repayDivideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.bottom.equalTo(70*UIRate)
        }

        repayVerDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(repayHoldView)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(-SCREEN_WIDTH/4)
            make.top.equalTo(33*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/2)
            make.centerX.equalTo(moneyTextLabel)
            make.bottom.equalTo(moneyTextLabel.snp.top)
        }

        dateTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.centerY.equalTo(moneyTextLabel)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/2)
            make.centerX.equalTo(dateTextLabel)
            make.centerY.equalTo(moneyLabel)
        }
        
        reBottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(repayHoldView)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(repayDivideLine.snp.bottom)
        }

        /***********/
        aCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(205*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(repayHoldView.snp.bottom)
        }

    }
    
    var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image_375x220")
        return imageView
    }()
    
    //／消息按钮
    private lazy var messageBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "m_message_25x25"), for: .normal)
        button.addTarget(self, action: #selector(messageBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／消息小红点
    private lazy var messageRedDot: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"m_red_point_6x6")
        imageView.isHidden = true
        return imageView
    }()
    
    //／设置按钮
    private lazy var settingBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "m_setting_25x25"), for: .normal)
        button.addTarget(self, action: #selector(settingBtnAction), for: .touchUpInside)
        return button
    }()
    
    //头像
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_heder_icon_90x90")
        return imageView
    }()
    
    var sayHelloTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFontSize(size: 15*UIRate)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        textLabel.text = "您好： 135****7788"
        return textLabel
    }()
    
    /*****************/
    private lazy var tipsHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColorHex("ffe0df")
        return holdView
    }()
    
    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("e9342d")
        label.text = "您有借款逾期，请尽早还款"
        return label
    }()

    /*************/
    private lazy var repayHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var repayDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var repayDivideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var repayVerDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "本月待还(元)"
        return label
    }()

    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "0.00"
        return label
    }()

    private lazy var dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "下期还款日"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "11月11日"
        return label
    }()

    private lazy var reBottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
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
            cell.textLabel.text = "还款明细"
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { //借款记录
            let borrowRecordVC = BorrowRecordViewController()
            self.navigationController?.pushViewController(borrowRecordVC, animated: true)
        }else if indexPath.row == 1 { //还款账单
            let repayVC = RepayBillViewController()
            self.navigationController?.pushViewController(repayVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MineHeaderView
            return headerView
            
        case UICollectionElementKindSectionFooter:
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! MineFooterView
            return footerView
        default:
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MineHeaderView
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 70*UIRate)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 60*UIRate)
    }
    
 //MARK: - Action
    func messageBtnAction() {//消息
        let messageVC = SysMessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func settingBtnAction(){
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
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
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
        

    }
    
    func refreshUI(json:JSON){
        self.messageCount = json["size"].intValue
        if json["jstatus"].stringValue == "5" {//有还款明细
            self.moneyLabel.text = json["MonthRefund"].stringValue
            self.dateLabel.text = json["nextMonthDay"].stringValue
        }
        if json["penalty_day"].intValue > 0 { //有逾期
            let day = json["penalty_day"].stringValue //天数
            let amount = json["demurrage"].stringValue //钱数
            
            self.tipsTextLabel.text = "您有1期借款已逾期\(day)天，费用\(amount)元，请及时还款"
        }
        let status = json["jstatus"].stringValue//个人中心借款状态
            headerView.tipImage1.isHidden = true
            headerView.tipImage2.isHidden = true
            headerView.tipImage3.isHidden = true
            headerView.tipImage4.isHidden = true
        //0 - 订单完结 2－ 审核中 3-满额通过 4-等待放款，教验中 5-还款中 7－审核悲剧 8-重新上传服务单 9-补交材料 99-录入中
        switch status {
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
