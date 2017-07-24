//
//  BorrowMoneyViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/14.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SnapKit
//上传成功协议
protocol UploadSuccessDelegate: class {
    func upLoadInfoSuccess()
}

class BorrowMoneyViewController: UIViewController,iCarouselDelegate, iCarouselDataSource, ReselectRoleDelegate,UploadSuccessDelegate {

    var indicatorConstraint: Constraint!
    var identityConstraint: Constraint!
    var productConstraint: Constraint!
    var workConstraint: Constraint!
    var schoolConstraint: Constraint!
    var incomeConstraint: Constraint!
    var contactConstraint: Constraint!
    var dataConstraint: Constraint!
    
    //图标的颜色
    var imageColor = ("gray","gray","gray","gray","gray","gray","gray")
    //图标排布
    var offsetDis: CGFloat = 55*UIRate
    
    //角色类型
    var roleType: RoleType = .worker

    //当前位置
    var currentIndex = 0
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
       self.roleType = RoleType(rawValue: UserHelper.getUserRole()!)!
        
       self.setupUI()
       self.changeViewWithRoleTypeAndInfo()
       //当前所选中的View
       self.carousel.currentItemIndex = currentIndex
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //移除
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upLoadInfoSuccess()
        self.carouselCurrentItemIndexDidChange(carousel)
    }
    
    //基本UI
    func setupUI(){
        self.navigationItem.title = "我要借款"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(topView)
         
        self.view.addSubview(holdView)
        self.view.addSubview(divideLine2)
        
        self.view.addSubview(indicatorImageView)
    
        self.view.addSubview(workImageView)
        self.view.addSubview(schoolImageView)
        self.view.addSubview(incomeImageView)
        self.view.addSubview(productImageView)
        self.view.addSubview(identityImageView)
        self.view.addSubview(contactImageView)
        self.view.addSubview(dataImageView)

        self.view.addSubview(carousel)
        
        topView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(30*UIRate)
            make.top.equalTo(64)
        }
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(50*UIRate)
            make.top.equalTo(topView.snp.bottom).offset(10*UIRate)
            make.left.equalTo(self.view)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(holdView)
        }
        
        //icon
        indicatorImageView.snp.makeConstraints { (make) in
            make.width.equalTo(38.5*UIRate)
            make.height.equalTo(38.5*UIRate)
            make.bottom.equalTo(holdView)
            self.indicatorConstraint = make.centerX.equalTo(self.identityImageView).constraint
        }
        
        workImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView)
            self.workConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        schoolImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView)
            self.schoolConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        incomeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView)
            self.incomeConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        productImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView).offset(-offsetDis)
            self.productConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        identityImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.right.equalTo(productImageView.snp.left).offset(-25*UIRate)
            self.identityConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        contactImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.centerX.equalTo(holdView).offset(offsetDis)
            self.contactConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        dataImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.left.equalTo(contactImageView.snp.right).offset(25*UIRate)
            self.dataConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        //详细资料图
        carousel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(350*UIRate)
            make.top.equalTo(holdView.snp.bottom).offset(20*UIRate)
            make.centerX.equalTo(self.view)
        }
    }
    
    //根据角色和信息上传量改变View
    func changeViewWithRoleTypeAndInfo(){
        
        self.judgeUploadInfo()//判读上传信息
        switch self.roleType {
        case .worker:
            self.schoolImageView.isHidden = true
            self.workImageView.isHidden = false
            self.incomeImageView.isHidden = true
            break
        case .student:
            self.workImageView.isHidden = true
            self.schoolImageView.isHidden = false
            self.incomeImageView.isHidden = true
            break
        case .freedom:
             self.schoolImageView.isHidden = true
             self.workImageView.isHidden = true
             self.incomeImageView.isHidden = false
            break
        }
    }
    
    /******/
    private lazy var topView: BorrowMoneyTopTipsView = {
        let holdView = BorrowMoneyTopTipsView(viewType: BorrowMoneyTopTipsView.TipsType.tips1)
        return holdView
    }()
    
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColorHex("fbfbfb")
        return holdView
    }()
    
    //MARK: - 5个icon
    
    //指示图
    private lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "data_indicator_white_38.5x38.5")
        return imageView
    }()
    
    private lazy var identityImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_identity_gray_30x30")
        return imageView
    }()
    
    private lazy var productImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_product_gray_30x30")
        return imageView
    }()
    
    private lazy var workImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_work_gray_30x30")
        return imageView
    }()
    
    private lazy var schoolImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_school_gray_30x30")
        return imageView
    }()
    
    private lazy var incomeImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_income_gray_30x30")
        return imageView
    }()
    
    private lazy var contactImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_contact_gray_30x30")
        return imageView
    }()
    
    private lazy var dataImageView: BorrowMoneyDoneView = {
        let imageView = BorrowMoneyDoneView()
        imageView.imageView.image = UIImage(named: "data_data_gray_30x30")
        return imageView
    }()
    
    ///轮播界面
    private lazy var carousel: iCarousel = {
        
        let carousel = iCarousel()
        carousel.type = .linear
        carousel.delegate = self
        carousel.dataSource = self
        
        return carousel
    }()

    //MARK: - 轮播界面
    private lazy var identityView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .identity)
        popView.holdTipsView.isHidden = true
        popView.writeBtn.isHidden = false
        return popView
    }()
    
    private lazy var productView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .product)
        return popView
    }()
    
    private lazy var workView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .work)
        return popView
    }()
    
    private lazy var schoolView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .school)
        return popView
    }()
    
    private lazy var incomeView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .income)
        return popView
    }()

    
    private lazy var contactView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .contact)
        return popView
    }()
    
    private lazy var dataView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .data)
        return popView
    }()
    
    //MARK: - iCarouselDelegate&&iCarouselDataSource
    func numberOfItems(in carousel: iCarousel) -> Int {
        return  5
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: BorrowMoneyView
        
        switch index {
        case 0:
            itemView = identityView
            identityView.onClickBtn = {[unowned self] viewType in
                let idVC = IdentityViewController()
                idVC.delegate = self
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }

        case 1:
            itemView = productView
            productView.onClickBtn = {[unowned self] viewType in
                let idVC = ProductViewController()
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
        case 2:
            switch self.roleType {
            case .worker:
                itemView = workView
                workView.onClickBtn = {[unowned self] viewType in
                    let idVC = WorkViewController()
                    idVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(idVC, animated: true)
                }
            case .student:
                itemView = schoolView
                schoolView.onClickBtn = {[unowned self] viewType in
                    let idVC = SchoolViewController()
                    idVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(idVC, animated: true)
                }
            case .freedom:
                itemView = incomeView
                incomeView.onClickBtn = {[unowned self] viewType in
                    let incomeVC = IncomeViewController()
                    incomeVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(incomeVC, animated: true)
                }
            }
        case 3:
            itemView = contactView
            contactView.onClickBtn = {[unowned self] viewType in
                let idVC = ContactViewController()
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
        case 4:
            itemView = dataView
            itemView.onClickBtn = {[unowned self] viewType in
                let idVC = DataViewController(roleType: self.roleType)
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
        default:
            itemView = dataView
        }
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .spacing {
            return value * 1.1
        }
        return value
    }
       
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
       
        let i = carousel.currentItemIndex
        
        self.indicatorConstraint.update(offset: CGFloat(i)*55*UIRate)
        self.changeOtherViewStates()
        
        switch i {
        case 0:
            identityImageView.imageView.image = UIImage(named:"data_identity_light_30x30")
            self.identityConstraint.update(offset: 15*UIRate)
        case 1:
            productImageView.imageView.image = UIImage(named:"data_product_light_30x30")
            self.productConstraint.update(offset: 15*UIRate)
        case 2:
            if self.roleType == .worker {
                workImageView.imageView.image = UIImage(named:"data_work_light_30x30")
                self.workConstraint.update(offset: 15*UIRate)
            }else if self.roleType == .student{
                schoolImageView.imageView.image = UIImage(named:"data_school_light_30x30")
                self.schoolConstraint.update(offset: 15*UIRate)
            } else {
                incomeImageView.imageView.image = UIImage(named:"data_income_light_30x30")
                self.incomeConstraint.update(offset: 15*UIRate)
            }
        case 3:
            contactImageView.imageView.image = UIImage(named:"data_contact_light_30x30")
            self.contactConstraint.update(offset: 15*UIRate)
           
        case 4:
            dataImageView.imageView.image = UIImage(named:"data_data_light_30x30")
            self.dataConstraint.update(offset: 15*UIRate)
        default:
            break
        }
    }
    
    ///改变未选中状态
    func changeOtherViewStates(){
        
        self.identityConstraint.update(offset: 10*UIRate)
        self.productConstraint.update(offset: 10*UIRate)
        self.workConstraint.update(offset: 10*UIRate)
        self.schoolConstraint.update(inset: 10*UIRate)
        self.incomeConstraint.update(offset: 10*UIRate)
        self.contactConstraint.update(offset: 10*UIRate)
        self.dataConstraint.update(offset: 10*UIRate)
        
        identityImageView.imageView.image = UIImage(named:"data_identity_\(imageColor.0)_30x30")
        productImageView.imageView.image = UIImage(named:"data_product_\(imageColor.1)_30x30")
        workImageView.imageView.image = UIImage(named:"data_work_\(imageColor.2)_30x30")
        schoolImageView.imageView.image = UIImage(named:"data_school_\(imageColor.3)_30x30")
        incomeImageView.imageView.image = UIImage(named:"data_income_\(imageColor.4)_30x30")
        contactImageView.imageView.image = UIImage(named:"data_contact_\(imageColor.5)_30x30")
        dataImageView.imageView.image = UIImage(named:"data_data_\(imageColor.6)_30x30")
    }

    //MARK: - Method
    //判断上传了多少信息
    func judgeUploadInfo(){
        if UserHelper.getIdentityIsUpload() {
            imageColor.0 = "light"
            identityImageView.finishImageView.isHidden = false
            if UserHelper.getIsReject() { //如果是被驳回
                identityView.holdTipsView.isHidden = false
                identityView.writeBtn.isHidden = true
            }
            productView.holdTipsView.isHidden = true
            productView.writeBtn.isHidden = false
        }
        if UserHelper.getProductIsUpload() {
            imageColor.1 = "light"
            productImageView.finishImageView.isHidden = false
            
            switch self.roleType {
            case .student:
                schoolView.holdTipsView.isHidden = true
                schoolView.writeBtn.isHidden = false
            case .worker:
                workView.holdTipsView.isHidden = true
                workView.writeBtn.isHidden = false
            case .freedom:
                incomeView.holdTipsView.isHidden = true
                incomeView.writeBtn.isHidden = false
            }
        }
        if UserHelper.getWorkIsUpload() {
            imageColor.2 = "light"
            workImageView.finishImageView.isHidden = false
            contactView.holdTipsView.isHidden = true
            contactView.writeBtn.isHidden = false
        }
        if UserHelper.getSchoolIsUpload() {
            imageColor.3 = "light"
            schoolImageView.finishImageView.isHidden = false
            contactView.holdTipsView.isHidden = true
            contactView.writeBtn.isHidden = false
        }
        if UserHelper.getIncomeIsUpload() {
            imageColor.4 = "light"
            incomeImageView.finishImageView.isHidden = false
            contactView.holdTipsView.isHidden = true
            contactView.writeBtn.isHidden = false
        }
        
        if UserHelper.getContactIsUpload() {
            imageColor.5 = "light"
            contactImageView.finishImageView.isHidden = false
            dataView.holdTipsView.isHidden = true
            dataView.writeBtn.isHidden = false
        }
        if UserHelper.getDataIsUpload() {
            imageColor.6 = "light"
            dataImageView.finishImageView.isHidden = false
            if UserHelper.getIsReject() { //如果是被驳回
                dataView.holdTipsView.isHidden = false
                dataView.writeBtn.isHidden = true
            }
        }
    }
    
    //返回键
    func leftNavigationBarBtnAction(){
        self.carousel.isHidden = true
        _ = self.navigationController?.popViewController(animated: true)
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: noticeBorrowAgainAction), object: self)
    }
    
    //MARK: - ReselectRoleDelegate
    func changeRoleType(role: RoleType) {
        self.roleType = role
        self.changeViewWithRoleTypeAndInfo()
        self.carousel.reloadData()
    }
    
    //MARK: - UpLoadInfoSuccess
    func upLoadInfoSuccess(){
        self.changeViewWithRoleTypeAndInfo()
        self.carousel.reloadData()
    }
}

