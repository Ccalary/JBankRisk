//
//  DataReuploadVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/24.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  补交材料

import UIKit
import SwiftyJSON
import Photos

class DataReuploadVC:  UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoPickerControllerDelegate{
    
    var dataCellArray = UserInfoCellModel(dataType: UserInfoCellModel.CellModelType.dataReupload)
    
    weak var uploadSucDelegate:UploadSuccessDelegate?
    
    var tableViewHeight: CGFloat!
    
    //相册多选
    var selectModel = [PhotoImageModel]()
    
    ///相机，相册
    var cameraPicker: UIImagePickerController!
    //    var photoPicker: UIImagePickerController!
    ///图片与描述
    var photoArray:[(image:UIImage,dis:String,selectCell: Int)] = [] {
        didSet{
            self.aCollectionView.reloadData()
        }
    }
    
    var dis: String!
    var selectCell: Int!
    
    //上传张数
    var numArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHeight = CGFloat(dataCellArray.cellData.count)*50*UIRate
        
        numArray = Array(repeating: 0, count: dataCellArray.cellData.count)
        
        self.setupUI()
        self.initCameraPicker()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.bigBgholdView.removeFromSuperview()
    }

    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "补交材料"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
        self.view.addSubview(topView)
       
        self.view.addSubview(aScrollView)
        self.aScrollView.addSubview(aTableView)
        self.aScrollView.addSubview(divideLine1)
        self.aScrollView.addSubview(aCollectionView)
        
        /******点击图片放大*****/
        UIApplication.shared.keyWindow?.addSubview(bigBgholdView)
        self.bigBgholdView.addSubview(bigImageView)
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.bigBgholdView.addGestureRecognizer(aTap)
        
        
        topView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(30*UIRate)
            make.top.equalTo(64)
        }
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 84*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 30*UIRate)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(aScrollView)
            make.height.equalTo(tableViewHeight)
            make.centerX.equalTo(aScrollView)
            make.top.equalTo(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.aScrollView)
            make.top.equalTo(aTableView)
        }
        
        aCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(262*UIRate)
            make.centerX.equalTo(aScrollView)
            make.top.equalTo(self.aTableView.snp.bottom).offset(10*UIRate)
        }
        
        /*******/
        bigBgholdView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
        
        bigImageView.snp.makeConstraints { (make) in
            make.size.equalTo(bigBgholdView)
            make.center.equalTo(bigBgholdView)
        }
        
        bigImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.reupLoadSetupUI()
    }
    
   //补交材料
    func reupLoadSetupUI(){
    
        self.nextStepBtn.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        
        self.view.addSubview(nextStepBtn)
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-10*UIRate)
        }
        
        let scrollHeight = SCREEN_HEIGHT - 64 - 64*UIRate - 20*UIRate
        let contentHeight = tableViewHeight + 262*UIRate + 20*UIRate
        
        if contentHeight < scrollHeight {
            aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: scrollHeight + 1)
        }else{
            aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: contentHeight)
        }
    }
    
    fileprivate lazy var bigBgholdView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.8)
        return holdView
    }()
    
    //图片
    fileprivate lazy var bigImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /******/
    private lazy var topView: BorrowMoneyTopTipsView = {
        let holdView = BorrowMoneyTopTipsView(viewType: BorrowMoneyTopTipsView.TipsType.tips2)
        return holdView
    }()
    
    private lazy var aScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "DataCellID")
        
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
        
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 106*UIRate, height: 131*UIRate)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: "dataCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setTitle("提交申请", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／上一步按钮
    private lazy var lastStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_85x44"), for: .normal)
        button.setTitle("上一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(lastStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var botTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "申请代表你同意"
        return label
    }()
    
    //／按钮
    private lazy var protocolBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFontSize(size: 12*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.setTitle("《相关协议》", for: .normal)
        button.addTarget(self, action: #selector(protocolBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - UITableViewDelegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCellArray.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = dataCellArray.cellData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupView = PopupPhotoSelectView()
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        selectCell = indexPath.row
        popupView.onClickCamera = {_ in //相机
            popupController.dismiss(animated: true)
            self.present(self.cameraPicker, animated: true, completion: nil)
        }
        popupView.onClickPhoto = { _ in //相册选取
            
            self.selectFromPhoto()
            popupController.dismiss(animated: true)
        }
        
        popupView.onClickClose = { _ in //关闭
            popupController.dismiss(animated: true)
        }
    }
    
    /******************/
    //MARK: - collectionView delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataCollectionViewCell
        cell.imageView.image = photoArray[indexPath.row].image
        cell.textLabel.text = photoArray[indexPath.row].dis
        
        cell.onClickDelete = { _ in
            let selectCell = self.photoArray[indexPath.row].selectCell
            self.numArray[selectCell] -= 1
            if self.numArray[selectCell] > 0{
                self.dataCellArray.cellData[selectCell].content = "已上传\(self.numArray[selectCell])张"
            }else {
                self.dataCellArray.cellData[selectCell].content = ""
            }
            self.reloadOneTabelViewCell(at: selectCell)
            
            self.photoArray.remove(at: indexPath.row)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        bigImageView.image = photoArray[indexPath.row].image
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseIn, animations: { _ in
            self.bigBgholdView.alpha = 1
            self.bigImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    
    //MARK: - Method
    func initCameraPicker(){
        cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //主线程刷新
        DispatchQueue.main.async {
            self.photoArray.append((image,self.dataCellArray.cellData[self.selectCell].leftText,self.selectCell))
            self.numArray[self.selectCell] += 1
            self.dataCellArray.cellData[self.selectCell].content = "已上传\(self.numArray[self.selectCell])张"
            self.reloadOneTabelViewCell(at: self.selectCell)
        }
    }
    
    //刷新某行
    func reloadOneTabelViewCell(at index: Int){
        let position = IndexPath(item: index, section: 0)
        self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
    }
}

//MARK: - Action
extension DataReuploadVC {
    
    func tapViewAction(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: { _ in
            self.bigBgholdView.alpha = 0
            self.bigImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: nil)
    }
    
    //申请协议
    func protocolBtnAction(){
        let webVC = BaseWebViewController()
        webVC.requestUrl = BM_APPLY_PROTOCOL
        webVC.webTitle = "电子协议"
        self.navigationController?.pushViewController(webVC, animated: false)
    }
    
    func lastStepBtnAction(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //返回
    func leftNavigationBarBtnAction(){
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    //提交申请
    func nextStepBtnAction(){
       self.reuploadPhoto()
    }
    
    //MARK: - 补交附件
    func reuploadPhoto(){
        
//        //每条信息至少上传一张照片
//        for i in 0..<numArray.count {
//            if dataCellArray.cellData[i].holdText.contains("选填") {
//                break
//            }else {
//                if numArray[i] == 0 {
//                    self.showHint(in: self.view, hint: "每条信息至少上传一张照片")
//                    return
//                }
//            }
//        }
        
        guard photoArray.count > 0 else {
            self.showHint(in: self.view, hint: "至少上传一张照片")
            return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint:"上传中...")
        
        var imageDataArray:[Data] = []
        var imageNameArray:[String] = []
        
        for i in 0..<photoArray.count {
            
            //2017.7.21 更改
            let dataImage = toolsZipImage(photoArray[i].image)
            imageDataArray.append(dataImage)
            
            let imageName = String(describing: NSDate()) + "\(i).png"
            imageNameArray.append(imageName)
        }
        
        //参数666-多张上传
        let params: [String: String] = ["userId":UserHelper.getUserId(), "flag":"999"]
        
        NetConnect.bm_upload_photo_info(params:params , data: imageDataArray, name: imageNameArray, success: { response in
            
            //隐藏HUD
            self.hideHud()
            
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.showHintInKeywindow(hint: "补交材料上传成功！",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            
            _ = self.navigationController?.popViewController(animated: true)
        }, failure: { error in
            //隐藏HUD
            self.hideHud()
        })
    }
}

/**
 从相册中选择图片
 */

extension DataReuploadVC {
    //相册选择图片
    fileprivate func selectFromPhoto(){
        
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            switch status {
            case .authorized:
                self.showLocalPhotoGallery()
                break
            default:
                self.showNoPermissionDailog()
                break
            }
        }
    }
    
    private func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLocalPhotoGallery(){
        let picker = PhotoPickerController(type: PageType.AllAlbum)
        picker.imageSelectDelegate = self
        picker.modalPresentationStyle = .popover
        
        // max select number
        PhotoPickerController.imageMaxSelectedNum = 10
        
        self.show(picker, sender: nil)
    }
    
    //delegate
    func onImageSelectFinished(images: [PHAsset]) {
        self.renderSelectImages(images: images)
    }
    
    private func renderSelectImages(images: [PHAsset]){
        let pixSize = 200*UIRate
        for item in images {
            self.selectModel.insert(PhotoImageModel(type: ModelType.Image, data: item), at: 0)
            
            let itemModel = self.selectModel[0]
            
            if let asset = itemModel.data {
                
                let imageOptions = PHImageRequestOptions()
                imageOptions.isSynchronous = true
                
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: pixSize, height: pixSize), contentMode: PHImageContentMode.aspectFill, options: imageOptions, resultHandler: { (image, info) -> Void in
                    
                    PrintLog(image)
                    if image != nil {
                        //主线程刷新
                        DispatchQueue.main.async {
                            self.photoArray.append((image!,self.dataCellArray.cellData[self.selectCell].leftText,self.selectCell))
                            self.numArray[self.selectCell] += 1
                            self.dataCellArray.cellData[self.selectCell].content = "已上传\(self.numArray[self.selectCell])张"
                            self.reloadOneTabelViewCell(at: self.selectCell)
                        }
                    }
                })
            }
        }
    }
}
