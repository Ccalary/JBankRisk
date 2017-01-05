//
//  AboutOursViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutOursViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let instructionText = "        深圳中诚信佳金融服务有限公司简称中诚消费，成立于二零一四年，是一家专为年轻人提供优质消费金融服务的互联网金融公司。\n        中诚消费致力于打造专业可靠的消费分期服务平台，在利用金融产品满足顾客消费需求的同时，整合线下渠道资源，帮助其扩大消费人群，降低消费门槛。公司汇聚了金融，IT和市场营销等业界专业人士，结合全球金融发展趋势，创造新的金融模式，融合互联网技术，为广大客户提供新型互联网消费金融信息服务平台。"
    
    let leftTextInfo = ["","服务热线","客服邮箱","公司网址","","最新版本"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.instructTextLabel.attributedText = changeTextLineSpace(text: instructionText, lineSpace: 2*UIRate)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupUI() {
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "关于我们"
        
        self.view.addSubview(topHoldView)
        self.topHoldView.addSubview(logoImageView)
        self.topHoldView.addSubview(versionTextLabel)
        self.topHoldView.addSubview(instructTextLabel)
        self.topHoldView.addSubview(divideLine1)
        self.view.addSubview(aTableView)
        
        topHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(290*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

        logoImageView.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(35*UIRate)
            make.centerX.equalTo(topHoldView)
            make.top.equalTo(10*UIRate)
        }
        
        versionTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topHoldView)
            make.top.equalTo(logoImageView.snp.bottom).offset(5*UIRate)
        }

        instructTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 40*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(versionTextLabel.snp.bottom).offset(5*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(topHoldView)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(220*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topHoldView.snp.bottom)
        }

    }
    
    private lazy var topHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()

    
    //图片
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "s_logo_150x35")
        return imageView
    }()
    
    private lazy var versionTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "v." + APP_VERSION  //版本号
        return label
    }()
    
    private lazy var instructTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()


    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        tableView.register(AboutOursTableViewCell.self, forCellReuseIdentifier: "oursCellID")
        
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
        return leftTextInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oursCellID") as! AboutOursTableViewCell
        //去除选择效果
        cell.backgroundColor = UIColor.white
        cell.leftTextLabel.text = leftTextInfo[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = defaultBackgroundColor
        case 1:
            cell.leftImageView.image = UIImage(named:"s_phone_20x20")
            cell.rightTextLabel.text = "400-9669-636\n(9:00-17:00)"
            cell.arrowImageView.isHidden = false
        case 2:
            cell.leftImageView.image = UIImage(named:"s_email_20x20")
            cell.rightTextLabel.text = "postmater@zc-cfc.com"
        case 3:
            cell.leftImageView.image = UIImage(named:"s_website_20x20")
            cell.rightTextLabel.text = "www.zc-cfc.com"
        case 4:
            cell.backgroundColor = defaultBackgroundColor
        case 5:
            cell.leftImageView.image = UIImage(named:"s_new_version_20x20")
            cell.rightTextLabel.text = APP_VERSION
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 4{
            return 10*UIRate
        }else {
            return 50*UIRate
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 1://服务热线
            let phoneCallView = PopupPhoneCallView()
            let popupController = CNPPopupController(contents: [phoneCallView])!
            popupController.present(animated: true)
            
            phoneCallView.onClickCancel = {_ in
                popupController.dismiss(animated:true)
            }
            phoneCallView.onClickCall = {_ in
                popupController.dismiss(animated: true)
            }
        case 2://邮箱
            let copyWeb = UIPasteboard.general
            copyWeb.string = "postmater@zc-cfc.com"
            
            let phoneCallView = PopupCopyNoticeView(viewType: .email)
            let popupController = CNPPopupController(contents: [phoneCallView])!
            popupController.present(animated: true)
            
            phoneCallView.onClickCall = {_ in
                popupController.dismiss(animated: true)
            }
            
        case 3://网址
            let copyWeb = UIPasteboard.general
            copyWeb.string = "www.zccfc.com"
            
            let phoneCallView = PopupCopyNoticeView(viewType: .web)
            let popupController = CNPPopupController(contents: [phoneCallView])!
            popupController.present(animated: true)
    
            phoneCallView.onClickCall = {_ in
                popupController.dismiss(animated: true)
            }
        case 5://版本更新
            self.requestUpdataVersion()
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
    
    //请求版本更新
    func requestUpdataVersion(){
        
        var params = NetConnect.getBaseRequestParams()
        params["channel"] = "3"
        params["versionCode"] = APP_VERSION_CODE
        
        NetConnect.other_updata_version(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                //0-无更新 1-有更新 2-强制更新
                if json["vjstatus"].stringValue == "1" || json["vjstatus"].stringValue == "2" {
                    let popupView =  PopupNewVersionView(disText: json["updateDesc"].stringValue)
                    let popupController = CNPPopupController(contents: [popupView])!
                    popupController.present(animated: true)
                    popupView.onClickCancle = { _ in
                        
                        if json["vjstatus"].stringValue == "2" {
                            //强制更新，弹窗消不去
                        }else {
                            popupController.dismiss(animated: true)
                        }
                    }
                    //升级
                    popupView.onClickSure = { _ in
                        let appstoreUrl = json["updateUrl"].stringValue
                        let url = URL(string: appstoreUrl)
                        if let url = url {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }else if json["vjstatus"].stringValue == "0"{
                    self.showHint(in: self.view, hint: "已是最新版本")
                }
        }, failure: {error in
            
        })
    }

}
