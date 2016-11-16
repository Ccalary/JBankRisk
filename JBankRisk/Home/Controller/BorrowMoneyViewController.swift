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
protocol UploadSuccessDelegate {
    func upLoadInfoSuccess()
}

class BorrowMoneyViewController: UIViewController,iCarouselDelegate, iCarouselDataSource, ReselectRoleDelegate,UploadSuccessDelegate {

    var indicatorConstraint: Constraint!
    var identityConstraint: Constraint!
    var productConstraint: Constraint!
    var workConstraint: Constraint!
    var schoolConstraint: Constraint!
    var contactConstraint: Constraint!
    var dataConstraint: Constraint!
    
    var proCenterXConstraint: Constraint!
    var conCenterXConstraint: Constraint!
    
    //图标的颜色
    var imageColor = ("gray","gray","gray","gray","gray","gray")
    //图标排布
    var offsetDis: CGFloat!
    
    //角色类型
    var roleType: RoleType = .worker
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
       self.roleType = RoleType(rawValue: UserHelper.getUserRole()!)!
       //icon排布
       self.iconOffsetSize()
        
       self.setupUI()
       self.changeViewWithRoleTypeAndInfo()
       //当前所选中的View
       self.carouselCurrentItemIndexDidChange(carousel)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        //判断carousel是否移除
//        if carousel.superview !== self.view{
//             self.view.addSubview(carousel)
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {

//        self.carousel.removeFromSuperview()
    }
    
    //基本UI
    func setupUI(){
        self.title = "我要借款"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(topView)
        self.view.addSubview(topTextLabel)
        self.view.addSubview(starImageView)
        self.view.addSubview(divideLine1)
        
        self.view.addSubview(holdView)
        self.view.addSubview(divideLine2)
        
        self.view.addSubview(indicatorImageView)
    
        self.view.addSubview(workImageView)
        self.view.addSubview(schoolImageView)
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
        
        topTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(topView)
            make.centerX.equalTo(topView).offset(9*UIRate)
        }
        
        starImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(topTextLabel.snp.left).offset(-3*UIRate)
            make.centerY.equalTo(topTextLabel)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(topView)
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
        
        productImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            self.proCenterXConstraint = make.centerX.equalTo(holdView).offset(-offsetDis).constraint
            self.productConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        identityImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.right.equalTo(productImageView.snp.left).offset(-25*UIRate)
            self.identityConstraint = make.top.equalTo(holdView).offset(10*UIRate).constraint
        }
        
        contactImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            self.conCenterXConstraint = make.centerX.equalTo(holdView).offset(offsetDis).constraint
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
        self.iconOffsetSize()
        self.proCenterXConstraint.update(offset: -offsetDis)
        self.conCenterXConstraint.update(offset: offsetDis)
        switch self.roleType {
        case .worker:
            self.schoolImageView.isHidden = true
            self.workImageView.isHidden = false
            break
        case .student:
            self.workImageView.isHidden = true
            self.schoolImageView.isHidden = false
            break
        case .freedom:
             self.schoolImageView.isHidden = true
             self.workImageView.isHidden = true
            break
        }
    }
    
    private lazy var topView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColorHex("fbfbfb")
        return holdView
    }()
    
    ///顶部文字
    private lazy var topTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "填写真实资料有助于提高您的贷款额度哦！"
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_star_15x15")
        return imageView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
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
    
    private lazy var contactView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .contact)
        return popView
    }()
    
    private lazy var dataView: BorrowMoneyView = {
        let popView = BorrowMoneyView(viewType: .data)
//        popView.holdTipsView.isHidden = false
//        popView.writeBtn.isHidden = true
        return popView
    }()
    
    //MARK: - iCarouselDelegate&&iCarouselDataSource
    func numberOfItems(in carousel: iCarousel) -> Int {
        return (self.roleType == .freedom) ? 4 : 5
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: BorrowMoneyView
        
        if index == 0 {
            itemView = identityView
            identityView.onClickBtn = { viewType in
                let idVC = IdentityViewController()
                idVC.delegate = self
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
        }else if index == 1{
            itemView = productView
            productView.onClickBtn = { viewType in
                let idVC = ProductViewController()
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
        }else if index == 2 {
            
            switch self.roleType {
            case .worker:
                itemView = workView
                workView.onClickBtn = { viewType in
                    let idVC = WorkViewController()
                    idVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(idVC, animated: true)
                }
            case .student:
                itemView = schoolView
                schoolView.onClickBtn = { viewType in
                    let idVC = SchoolViewController()
                    idVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(idVC, animated: true)
                }
            case .freedom:
                itemView = contactView
                contactView.onClickBtn = { viewType in
                    let idVC = ContactViewController()
                    idVC.uploadSucDelegate = self
                    self.navigationController?.pushViewController(idVC, animated: true)
                }
              }
            }else if index == 3 {
                if self.roleType == .freedom {
                    itemView = dataView
                    dataView.onClickBtn = { viewType in
                        let idVC = DataViewController(roleType: self.roleType)
                        idVC.uploadSucDelegate = self
                        self.navigationController?.pushViewController(idVC, animated: true)
                    }

                }else {
                    itemView = contactView
                    contactView.onClickBtn = { viewType in
                        let idVC = ContactViewController()
                        idVC.uploadSucDelegate = self
                        self.navigationController?.pushViewController(idVC, animated: true)
                    }
                }
        } else {
            itemView = dataView 
            itemView.onClickBtn = { viewType in
                let idVC = DataViewController(roleType: self.roleType)
                idVC.uploadSucDelegate = self
                self.navigationController?.pushViewController(idVC, animated: true)
            }
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
            break
        case 1:
            productImageView.imageView.image = UIImage(named:"data_product_light_30x30")
            self.productConstraint.update(offset: 15*UIRate)
            break
        case 2:
            if self.roleType == .worker {
                workImageView.imageView.image = UIImage(named:"data_work_light_30x30")
                self.workConstraint.update(offset: 15*UIRate)
            }else if self.roleType == .student{
                schoolImageView.imageView.image = UIImage(named:"data_school_light_30x30")
                self.schoolConstraint.update(offset: 15*UIRate)
            } else {
                contactImageView.imageView.image = UIImage(named:"data_contact_light_30x30")
                self.contactConstraint.update(offset: 15*UIRate)
            }
            break
        case 3:
            if self.roleType == .freedom {
                dataImageView.imageView.image = UIImage(named:"data_data_light_30x30")
                self.dataConstraint.update(offset: 15*UIRate)
            }else {
                contactImageView.imageView.image = UIImage(named:"data_contact_light_30x30")
                self.contactConstraint.update(offset: 15*UIRate)
            }
            break
        case 4:
            dataImageView.imageView.image = UIImage(named:"data_data_light_30x30")
            self.dataConstraint.update(offset: 15*UIRate)
            break
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
        self.contactConstraint.update(offset: 10*UIRate)
        self.dataConstraint.update(offset: 10*UIRate)
        
        identityImageView.imageView.image = UIImage(named:"data_identity_\(imageColor.0)_30x30")
        productImageView.imageView.image = UIImage(named:"data_product_\(imageColor.1)_30x30")
        workImageView.imageView.image = UIImage(named:"data_work_\(imageColor.2)_30x30")
        schoolImageView.imageView.image = UIImage(named:"data_school_\(imageColor.3)_30x30")
        contactImageView.imageView.image = UIImage(named:"data_contact_\(imageColor.4)_30x30")
        dataImageView.imageView.image = UIImage(named:"data_data_\(imageColor.5)_30x30")
    }

    //MARK: - Method
    func iconOffsetSize(){
        if self.roleType == .freedom {
            offsetDis = 27.5*UIRate
        }else {
            offsetDis = 55*UIRate
        }
    }
    
    //判断上传了多少信息
    func judgeUploadInfo(){
        if UserHelper.getIdentityIsUpload() {
             imageColor.0 = "light"
            identityImageView.finishImageView.isHidden = false
        }
        if UserHelper.getProductIsUpload() {
             imageColor.1 = "light"
            productImageView.finishImageView.isHidden = false
        }
        if UserHelper.getWorkIsUpload() {
            imageColor.2 = "light"
            workImageView.finishImageView.isHidden = false
        }
        if UserHelper.getSchoolIsUpload() {
            imageColor.3 = "light"
            schoolImageView.finishImageView.isHidden = false
        }
        if UserHelper.getContactIsUpload() {
            imageColor.4 = "light"
            contactImageView.finishImageView.isHidden = false
        }
        if UserHelper.getDataIsUpload() {
            imageColor.5 = "light"
            dataImageView.finishImageView.isHidden = false
        }
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

