//
//  SuggestViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SuggestViewController: UIViewController,UITextViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    let TOTAL_NUM = 200
    
    ///相机，相册
    var cameraPicker: UIImagePickerController!
    var photoPicker: UIImagePickerController!

    ///图片与描述
    var photoArray:[UIImage] = [UIImage(named: "s_header_icon_45x45")!] {
        didSet{
            self.aCollectionView.reloadData()
        }
    }
    
    var textNum = 0 {
        didSet {
            numTextLabel.text = "(\(textNum)/\(TOTAL_NUM))"
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
    
    func setupUI(){
        self.title = "我要吐槽"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_right_phone_18x21"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(textHoldView)
        self.view.addSubview(holderTextLabel)
        self.view.addSubview(mTextView)
        self.view.addSubview(numTextLabel)
        
        self.view.addSubview(aCollectionView)
        self.view.addSubview(sureBtn)
        
        textHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(180*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(10*UIRate + 64)
        }
        
        holderTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate - 16*UIRate)
            make.height.equalTo(45*UIRate)
            make.centerX.equalTo(textHoldView)
            make.top.equalTo(textHoldView).offset(10*UIRate)
        }

        mTextView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate - 14*UIRate)
            make.height.equalTo(160*UIRate)
            make.centerX.equalTo(textHoldView)
            make.top.equalTo(textHoldView).offset(10*UIRate)
        }
        
        numTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(textHoldView.snp.right).offset(-10*UIRate)
            make.bottom.equalTo(textHoldView).offset(-5*UIRate)
        }
        
        aCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(150*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.textHoldView.snp.bottom).offset(20*UIRate)
        }

        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-55*UIRate)
        }
        
    }
    
    private lazy var textHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        holdView.layer.borderWidth = 0.5*UIRate
        holdView.layer.borderColor = defaultDivideLineColor.cgColor
        return holdView
    }()
    
    private lazy var holderTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textColor = UIColorHex("c5c5c5")
        label.numberOfLines = 2
        label.text = " 来到这一定有话要说吧？期待您的反馈。\n 您可以拨打页面右侧上方的电话反馈或留言给我们。"
        return label
    }()

    private lazy var mTextView: UITextView = {
        let textField = UITextView()
        textField.font = UIFontSize(size: 12*UIRate)
        textField.textColor = UIColorHex("666666")
        textField.backgroundColor = UIColor.clear
        textField.isScrollEnabled = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var numTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "(0/200)"
        return label
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 66*UIRate, height: 66*UIRate)
        layout.minimumLineSpacing = 10*UIRate
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(SuggestCollectionViewCell.self, forCellWithReuseIdentifier: "suggestCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()

    
    //／按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("提交", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - collectionView delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestCell", for: indexPath) as! SuggestCollectionViewCell
        
        if indexPath.row == photoArray.count - 1{
            cell.cameraImageView.isHidden = false
            cell.deleteBtn.isHidden = true
            cell.holdView.isHidden = false
            cell.textLabel.text = "上传资料"
        }else {
            cell.imageView.image = photoArray[indexPath.row]
            cell.cameraImageView.isHidden = true
            cell.deleteBtn.isHidden = false
            cell.holdView.isHidden = true
            cell.textLabel.text = ""
        }
        
        cell.onClickDelete = { _ in
            self.photoArray.remove(at: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
      {
        if indexPath.row == photoArray.count - 1 {
            
            
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
        if photoArray.count < 6 {
            photoArray.insert(image, at: 0)
        }else {
            //最多上传6张
        }
     }
    
    //MAERK: - gestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view !== self.aCollectionView {
            return false
        }else {
            return true
        }
    }
    
    //MARK: - TextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.characters.count > 150 {
            
            //获得已输出字数与正输入字母数
            let selectRange = textView.markedTextRange
           
            //获取高亮部分 － 如果有联想词则解包成功
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    return
                }
            }
            
            let textContent = textView.text
            let textNum = textContent?.characters.count
            
            //截取200个字
            if textNum! > TOTAL_NUM {
                let index = textContent?.index((textContent?.startIndex)!, offsetBy: TOTAL_NUM)
                let str = textContent?.substring(to: index!)
                textView.text = str
            }
        }
        
        self.textNum = textView.text.characters.count
        if self.textNum != 0 {
            holderTextLabel.isHidden = true
            
        }else {
            holderTextLabel.isHidden = false
        }
    }
    
    //电话按钮点击
    func rightNavigationBarBtnAction(){
        
        self.view.endEditing(true)
        
        let phoneCallView = PopupPhoneCallView()
        let popupController = CNPPopupController(contents: [phoneCallView])!
        popupController.present(animated: true)
        
        phoneCallView.onClickCancel = {_ in
            popupController.dismiss(animated:true)
        }
        phoneCallView.onClickCall = {_ in
            popupController.dismiss(animated: true)
        }
        
    }
    
    func tapViewAction(){
        self.view.endEditing(true)
    }

    //提交
    func sureBtnAction() {
        
    }

}
