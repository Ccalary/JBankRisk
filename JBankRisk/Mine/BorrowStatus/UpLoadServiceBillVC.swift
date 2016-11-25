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

    ///相机，相册
    var cameraPicker: UIImagePickerController!
    var photoPicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.initPhotoPicker()
        self.initCameraPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.title  = "服务使用"
        
        self.view.addSubview(holdView)
        self.holdView.addSubview(divideLine1)
        self.holdView.addSubview(divideLine2)
        self.holdView.addSubview(textLabel)
        self.view.addSubview(photoBtn)
        
        self.view.addSubview(imageView)
        
        self.view.addSubview(nextStepBtn)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(300*UIRate)
            make.height.equalTo(180*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 30*UIRate)
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

    }
    
    //确认上传
    func nextStepBtnAction(){
        self.uploadBillImage(image: self.imageView.image!)
    }
    
    func uploadBillImage(image:UIImage){
        
        var imageDataArray:[Data] = []
        var imageNameArray:[String] = []
        
        imageDataArray.append(UIImageJPEGRepresentation(image, 0.1)!)
        let imageName = String(describing: NSDate()) + ".png"
        imageNameArray.append(imageName)
        
        self.showHud(in: self.view,hint:"上传中...")
        //参数999-服务单上传
        let params: [String: String] = ["userId":UserHelper.getUserId()!, "flag":"999"]
        
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
