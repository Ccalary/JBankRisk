//
//  NeedRepayViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/12.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  还款记录（应还总额）

import UIKit
import SnapKit

class NeedRepayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    //是否打开了下拉框
    var isTransformed: Bool = false
    var selectViewConstraint: Constraint?
    var titleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle()
        self.setupUI()
        self.selectViewClick()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTitle(){
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100*UIRate, height: 40))
        
        titleButton = UIButton(frame: CGRect(x: 10*UIRate, y: 0, width: 80*UIRate, height: 40))
        titleButton.setTitle("全部应还", for: .normal)
        titleButton.setTitleColor(UIColorHex("000000"), for: .normal)
        titleButton.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        titleView.addSubview(titleButton)
        titleView.addSubview(titleArrowImgView)
        
        titleArrowImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(6*UIRate)
            make.left.equalTo(titleButton.snp.right)
            make.centerY.equalTo(titleButton)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    //MARK: - 基本UI
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        selectBgView.addGestureRecognizer(aTap)
        
        self.view.addSubview(aTableView)
        self.aTableView.tableHeaderView = bannerImageView
        
        self.bannerImageView.addSubview(totalTextLabel)
        self.bannerImageView.addSubview(moneyLabel)
        
        self.view.addSubview(selectBgView)
        self.view.addSubview(selectView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(40*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalTextLabel.snp.bottom).offset(23*UIRate)
        }

        selectBgView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.center.equalTo(self.view)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(180*UIRate)
            make.centerX.equalTo(self.view)
            self.selectViewConstraint = make.top.equalTo(-180*UIRate).constraint
        }
    }
    
    //navigationBar图片
    private lazy var titleArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triangle_down_6x6")
        return imageView
    }()
    
    
    //top图片
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 156*UIRate))
        imageView.image = UIImage(named: "m_banner_image3_375x156")
        return imageView
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "合计应还(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "150,000.00"
        return label
    }()

    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "cellID")
        
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    //下拉选择View
    private lazy var selectView: NeedRepayTimeView = {
        let selectView = NeedRepayTimeView()
        return selectView
    }()

    //下拉时变暗背景
    private lazy var selectBgView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.6)
        return holdView
    }()
    

    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! RepayDetailTableViewCell
        //去除选择效果
//        cell.selectionStyle = .none
        cell.leftTopTextLabel2.text = "第4期"
        cell.leftTopTextLabel.text = "隆鼻"
        cell.leftBottomTextLabel.text = "2016.11.11"
        cell.statusTextLabel.text = "待还"
        cell.noticeTextLabel.text = "逾期5天"
        cell.moneyTextLabel.text = "600.00元"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

    ///消除手势与TableView的冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }

    
    //MARK: - Method
    //点击了下拉框的回调
    func selectViewClick(){
        selectView.onClickCell = { (title) in
            self.titleButton.setTitle(title, for: .normal)
            self.closeSelectView()
        }
    }
    
    //MARK: - Action
    
    func tapViewAction(){
        if isTransformed{
            self.closeSelectView()
        }
    }
    
    //头部图片点击
    func titleButtonAction(){
        
        if !isTransformed {
            //打开
            
            UIView.animate(withDuration: 0.6, animations: {
                 self.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                self.selectViewConstraint?.update(offset: 64)
                self.view.layoutIfNeeded()//一定要加上这句话才会有动画效果
                self.selectBgView.alpha = 1
            })
          
            isTransformed = !isTransformed
        }else {
            self.closeSelectView()
        }
        
    }
    
     //关闭
    func closeSelectView(){
       
        UIView.animate(withDuration: 0.6, animations: {
            self.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            self.selectViewConstraint?.update(offset: -180*UIRate)
            self.view.layoutIfNeeded()
            self.selectBgView.alpha = 0
        })
        isTransformed = !isTransformed
    }
    
}
