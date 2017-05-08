//
//  PopupRepayWayView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/3/19.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupRepayWayView: UIView,  UITableViewDelegate, UITableViewDataSource {

    var imageArray = ["r_wechat_25x25","r_alipay_25x25"]
    var dataArray = ["微信支付","支付宝支付"]
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
        self.setupUI()
    }

    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 150*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(holdView)
        self.addSubview(titleLabel)
        self.addSubview(closeBtn)
        self.addSubview(divideLine)
        self.addSubview(aTableView)
        
        holdView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(50*UIRate)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(holdView)
            make.centerX.equalTo(self)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(17*UIRate)
            make.right.equalTo(self).offset(-20*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        divideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(1)
            make.centerX.equalTo(self)
            make.bottom.equalTo(holdView.snp.bottom)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(2*50*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(holdView.snp.bottom)
        }
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = ColorTextBlack
        label.text = "选择支付方式"
        return label
    }()
    
    //分割线
    private lazy var divideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    ///关闭按钮
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bm_close_gray_17x17"), for: .normal)
        button.addTarget(self, action:#selector(closeBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false 
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "popCellID")
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popCellID")
        
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let onClickSelect = self.onClickSelect {
            onClickSelect(indexPath.row)
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
    
    var onClickSelect: ((_ row: Int)->())?
    var onClickCloseBtn: (()->())?
    //关闭
    func closeBtnAction(){        
        if let onClickCloseBtn = onClickCloseBtn {
            onClickCloseBtn()
        }
    }

}
