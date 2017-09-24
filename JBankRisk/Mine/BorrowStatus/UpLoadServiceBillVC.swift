//
//  UpLoadServiceBillVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/19.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpLoadServiceBillVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var orderId = ""
    //合同id
    var contractId = ""
    //是否进入了签字界面
    var isSign = false
    
    //合同
    var contractListArray: [JSON] = []
    ///相机，相册
    var cameraPicker: UIImagePickerController!
    var photoPicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //保存orderid,用来判断合同是否签完
        UserHelper.setUserNewOrderId(self.orderId)
        self.setupUI()
        self.initPhotoPicker()
        self.initCameraPicker()
        self.requestListData()
        self.onClickConstractAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isSign {
            self.requestListData()
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.title  = "服务使用"
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(headerView)
        self.view.addSubview(holdView)
        self.holdView.addSubview(divideLine1)
        self.holdView.addSubview(divideLine2)
        self.holdView.addSubview(textLabel)
        self.view.addSubview(photoBtn)
        
        self.view.addSubview(imageView)
        
        self.view.addSubview(nextStepBtn)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(10*UIRate)
            make.width.equalTo(self.view)
            make.height.equalTo(100*UIRate)
            make.centerX.equalTo(self.view)
        }
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(300*UIRate)
            make.height.equalTo(180*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(headerView.snp.bottom).offset(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(1*UIRate)
            make.height.equalTo(100*UIRate)
            make.centerY.equalTo(-8*UIRate)
            make.centerX.equalTo(holdView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(125*UIRate)
            make.height.equalTo(1*UIRate)
            make.center.equalTo(divideLine1)
        }
     
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(holdView)
            make.top.equalTo(divideLine1.snp.bottom).offset(5*UIRate)
        }
     
        photoBtn.snp.makeConstraints { (make) in
            make.size.equalTo(holdView)
            make.center.equalTo(holdView)
        }

        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(holdView)
            make.center.equalTo(holdView)
        }

        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(holdView.snp.bottom).offset(45*UIRate)
        }
   }
    
    private lazy var headerView: ServiceBillHeaderView = {
        let headerView = ServiceBillHeaderView()
        
        return headerView
    }()
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorHex("d0d0d0")
        return lineView
    }()

    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorHex("d0d0d0")
        return lineView
    }()

    //／按钮
    private lazy var photoBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(photoBtnAction), for: .touchUpInside)
        return button
    }()
    
    //图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColorHex("d0d0d0")
        label.text = "请拍照上传服务确认单\n通过校验即可使用"
        return label
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("确认使用", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    func tapViewAction(){
        self.view.endEditing(true)
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
        self.imageView.image = image
        self.nextStepBtn.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        self.nextStepBtn.isUserInteractionEnabled = true
    }

    //拍照
    func photoBtnAction(){
        self.view.endEditing(true)
        let popupView = PopupPhotoSelectView()
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickCamera = {[unowned self]_ in //相机
            popupController.dismiss(animated: true)
            self.present(self.cameraPicker, animated: true, completion: nil)
        }
        popupView.onClickPhoto = {[unowned self] _ in //相册选取
            
            self.present(self.photoPicker, animated: true, completion: nil)
            popupController.dismiss(animated: true)
        }
        popupView.onClickClose = { _ in //关闭
            popupController.dismiss(animated: true)
        }
    }
    
    //确认上传
    func nextStepBtnAction(){
        
        if !UserHelper.getContractIsSigned() {
            let popupView = PopupLogoutView()
            popupView.content = ("温馨提示","为了保障您的权益与服务，请\n签署电子合同","缓一缓","去签署")
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickCancle = {
                popupController.dismiss(animated: true)
            }
            
            popupView.onClickSure = {[unowned self] in
                popupController.dismiss(animated: true)
                
                self.signContract(flag: self.contractListArray[0]["flag"].stringValue)
                //多单合同时使用
//                let contractVC = ContractViewController()
//                contractVC.orderId = self.orderId
//                self.navigationController?.pushViewController(contractVC, animated: true)
            }
        }else {
            self.uploadBillImage(image: self.imageView.image!)
        }
    }
    
    //MARK:- 点击了电子合同
    func onClickConstractAction(){
        //回调
        headerView.onClick = {[weak self] _ in
            self?.view.endEditing(true)
            if UserHelper.getContractIsSigned(){
                //查看
                self?.seeContract(contractId: self?.contractId)
            }else {
                //签约
                self?.signContract(flag: self?.contractListArray[0]["flag"].stringValue)
            }
        }
    }
    
    //MARK:- 合同 请求数据
    func requestListData(){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        
        NetConnect.other_contract_list(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                self.contractListArray.removeAll()
                self.contractListArray = json["backList"].arrayValue
                
                if let dic = self.contractListArray.first{
                    //0- 未签署  1- 已签署
                    if dic["jstatus"].stringValue == "1" {
                        //是否签完合同
                        UserHelper.setContract(isSigned: true)
                        self.showHint(in: self.view, hint: "合同已签约完成，请上传服务单")
                        self.contractId = dic["contractId"].stringValue
                    }else {
                        UserHelper.setContract(isSigned: false)
                    }
                    self.headerView.isSigned = UserHelper.getContractIsSigned()
                }
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //MARK: - 合同签约
    func signContract(flag: String?){
        
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        params["flag"] = flag ?? ""
        
        NetConnect.other_contract_sign(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                self.isSign = true //进入了签字界面
                YHTSdk.setToken(json["backInfo"]["TOKEN"].stringValue)
                let YHTVC = YHTContractContentViewController.instance(withContractID: json["backInfo"]["contractId"].numberValue)
                self.navigationController?.pushViewController(YHTVC!, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }

    //合同查看
    func seeContract(contractId: String?){
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        params["contractId"] = contractId ?? ""
        
        NetConnect.other_contract_search(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                YHTSdk.setToken(json["backInfo"]["token"].stringValue)
                let YHTVC = YHTContractContentViewController.instance(withContractID: json["backInfo"]["contractId"].numberValue)
                YHTVC?.titleStr = "合同查看"
                self.navigationController?.pushViewController(YHTVC!, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }

    
    //MARK: 上传服务单
    func uploadBillImage(image:UIImage){
        
        var imageDataArray:[Data] = []
        var imageNameArray:[String] = []
        
        imageDataArray.append(UIImageJPEGRepresentation(image, 0.1)!)
        let imageName = String(describing: NSDate()) + ".png"
        imageNameArray.append(imageName)
        
        //卡号去除空格
        let cardNum = headerView.numTextField.text?.replacingOccurrences(of: " ", with: "")
        
        self.showHud(in: self.view,hint:"上传中...")
        //参数999-服务单上传, 2017.6.17 加传身份证验证
        let params: [String: String] = ["userId":UserHelper.getUserId(), "flag":"999","bankcard":cardNum ?? ""]
        
        NetConnect.bm_upload_photo_info(params:params , data: imageDataArray, name: imageNameArray, success: { response in
            
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.showHintInKeywindow(hint: "服务单上传成功",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            _ = self.navigationController?.popViewController(animated: true)
            
        }, failure: { error in
            //隐藏HUD
            self.hideHud()
        })
    }
}
