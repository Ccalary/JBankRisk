//
//  SettingViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class SettingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var leftTextInfo = ["头像","","手机号码","修改帐号密码","","关于我们","我要吐槽"]
    
    ///相机，相册
    var cameraPicker: UIImagePickerController!
    var photoPicker: UIImagePickerController!
    //头像地址
    var headerUrl: String = "" {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.initPhotoPicker()
        self.initCameraPicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        self.navHoldView.addSubview(navImageView)
        self.navHoldView.addSubview(navTextLabel)
        self.navHoldView.addSubview(navDivideLine)
        
        navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        navImageView.snp.makeConstraints { (make) in
            make.width.equalTo(13)
            make.height.equalTo(21)
            make.left.equalTo(19)
            make.centerY.equalTo(10)
        }
        
        navTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(navImageView)
        }
        
        navDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(navHoldView)
        }
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "设置"
        
        self.setNavUI()
        
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
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var navImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigation_left_back_13x21")
        return imageView
    }()
    
    private lazy var navTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //分割线
    private lazy var navDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

   /********/
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
        cell.arrowImageView.isHidden = false
        cell.headerImageView.isHidden = true
        cell.rightTextLabel.isHidden = true
        
        if indexPath.row == 1 || indexPath.row == 4 {
            cell.arrowImageView.isHidden = true
            cell.backgroundColor = defaultBackgroundColor
        }else if indexPath.row == 0 {
            cell.headerImageView.isHidden = false
            cell.headerImageView.kf_setImage(with: URL(string: UserHelper.getUserHeaderUrl() ?? ""), placeholder: UIImage(named: "s_header_icon_45x45"), options: nil, progressBlock: nil, completionHandler: nil)
        }else if indexPath.row == 2 {
            cell.rightTextLabel.text = UserHelper.getUserMobile()!
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
        case 0://
            let popupView = PopupPhotoSelectView()
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            popupView.onClickCamera = {_ in //相机
                popupController.dismiss(animated: true)
                self.present(self.cameraPicker, animated: true, completion: nil)
            }
            popupView.onClickPhoto = { _ in //相册选取
                
                self.present(self.photoPicker, animated: true, completion: nil)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in //关闭
                popupController.dismiss(animated: true)
            }
            break
        case 2://手机号码
            let viewController = ChangePhoneNumVC(phoneNum: UserHelper.getUserMobile()!)
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
    
    //MARK: - Method
    func initCameraPicker(){
        cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
    }
    
    func initPhotoPicker(){
        photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.uploadHeaderImage(image: image)
    }
    
    //退出登录
    func exitBtnAction(){
        
        let phoneCallView = PopupLogoutView()
        let popupController = CNPPopupController(contents: [phoneCallView])!
        popupController.present(animated: true)
        
        phoneCallView.onClickCancle = {_ in
            popupController.dismiss(animated:true)
        }
        phoneCallView.onClickSure = {_ in
            UserHelper.setLogoutInfo()
            popupController.dismiss(animated: true)
             self.tabBarController?.selectedIndex = 0
            _ = self.navigationController?.popToRootViewController(animated: true)
            self.showHintInKeywindow(hint: "退出登录", yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
        }
    }
    
    func uploadHeaderImage(image:UIImage){
        
        var imageDataArray:[Data] = []
        var imageNameArray:[String] = []
        
        imageDataArray.append(UIImageJPEGRepresentation(image, 0.1)!)
        let imageName = String(describing: NSDate()) + ".png"
        imageNameArray.append(imageName)
        
        self.showHud(in: self.view,hint:"上传中...")
        //参数000-头像上传
        let params: [String: String] = ["userId":UserHelper.getUserId()!, "flag":"000"]
        
        NetConnect.bm_upload_photo_info(params:params , data: imageDataArray, name: imageNameArray, success: { response in
            
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            let headerUrl = BASR_DEV_URL + json["requestMap"]["appPhoto"].stringValue
            //保存头像地址
            UserHelper.setUserHeader(headerUrl: headerUrl)
            let position = IndexPath(row: 0, section: 0)
            self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
            self.showHint(in: self.view, hint: "头像上传成功")
            
            
        }, failure: { error in
            //隐藏HUD
            self.hideHud()
            
        })

    }
    
}
