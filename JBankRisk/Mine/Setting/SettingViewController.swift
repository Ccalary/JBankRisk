//
//  SettingViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var leftTextInfo = ["头像","","手机号码","修改帐号密码","","关于我们","我要吐槽"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "设置"
        
        self.view.addSubview(aScrollView)
        self.aScrollView.addSubview(aTableView)
        self.aScrollView.addSubview(divideLine1)
        self.view.addSubview(exitBtn)
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 110*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

        aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 667*UIRate - 64 - 110*UIRate + 1)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(aScrollView)
            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(aScrollView)
            make.top.equalTo(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.aScrollView)
            make.top.equalTo(aTableView)
        }
        
        exitBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-55*UIRate)
        }
        
    }
    
    private lazy var aScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "setCellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    
    //／按钮
    private lazy var exitBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        button.setTitle("退出登录", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(exitBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - UITableViewDelegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftTextInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCellID") as! SettingTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.leftTextLabel.text = leftTextInfo[indexPath.row]
        cell.backgroundColor = UIColor.white
        
        if indexPath.row == 1 || indexPath.row == 4 {
            cell.arrowImageView.isHidden = true
            cell.backgroundColor = defaultBackgroundColor
        }else if indexPath.row == 0 {
            cell.headerImageView.isHidden = false
        }else if indexPath.row == 2 {
            cell.rightTextLabel.text = "1243223543543"
            cell.rightTextLabel.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 || indexPath.row == 4 {
            return 10*UIRate
        }else if indexPath.row == 0{
            return 60*UIRate
        }else {
            return 50*UIRate
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2://手机号码
            let viewController = ChangePhoneNumVC(phoneNum: "1232437824")
            self.navigationController?.pushViewController(viewController, animated: true)
        case 3: //重置密码
            let resetVC = ResetPsdViewController()
            self.navigationController?.pushViewController(resetVC, animated: true)
        case 5://关于我们
           let viewController = AboutOursViewController()
           self.navigationController?.pushViewController(viewController, animated: true)
        case 6://我要吐槽
            let viewController = SuggestViewController()
            self.navigationController?.pushViewController(viewController, animated: true)

        default:
            break
        }
        
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 ||  indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 {
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = .zero
            }
            if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                cell.layoutMargins = .zero
            }
        }else {
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 15*UIRate, bottom: 0, right: 0)
            }
            if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                cell.layoutMargins = UIEdgeInsets(top: 0, left: 15*UIRate, bottom: 0, right: 0)
            }
        }
    }
    
    func exitBtnAction(){
        
        let phoneCallView = PopupLogoutView()
        let popupController = CNPPopupController(contents: [phoneCallView])!
        popupController.present(animated: true)
        
        phoneCallView.onClickCancle = {_ in
            popupController.dismiss(animated:true)
        }
        phoneCallView.onClickSure = {_ in
            popupController.dismiss(animated: true)
        }
    }
    
}
