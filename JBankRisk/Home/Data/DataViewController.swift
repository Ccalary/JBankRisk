
//
//  DataViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class DataViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
    var WorkerCellData:[CellDataInfo] = [ CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "亲签照", holdText: "上传手持合同的照片", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "征信报告", holdText: "上传人民银行征信报告", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "财力证明", holdText: "上传可证明财力的文件（选填）", content: "", cellType: .cameraType)]
    
    var StudentCellData:[CellDataInfo] = [ CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "亲签照", holdText: "上传手持合同的照片", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "在读证明", holdText: "上传学信网个人信息或校园卡", content: "", cellType: .cameraType)]
    
    var FreedomCellData:[CellDataInfo] = [ CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "亲签照", holdText: "上传手持合同的照片", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "征信报告", holdText: "上传人民银行征信报告", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType),
                                          CellDataInfo(leftText: "财力证明", holdText: "上传可证明财力的文件（选填）", content: "", cellType: .cameraType)]
    
    var dataArray: [CellDataInfo]!
    var cellHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    init(roleType: RoleType) {
        super.init(nibName: nil, bundle: nil)
        
        switch roleType {
        case .worker:
            dataArray = WorkerCellData
        case .student:
            dataArray = StudentCellData
        case .freedom:
            dataArray = FreedomCellData
        }
        cellHeight = CGFloat(dataArray.count)*50*UIRate
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "学校信息"
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        UIApplication.shared.keyWindow?.addGestureRecognizer(aTap)
        
        self.view.addSubview(topView)
        self.view.addSubview(topTextLabel)
        self.view.addSubview(starImageView)
        self.view.addSubview(topDivideLine)
        
        self.view.addSubview(aScrollView)
        self.aScrollView.addSubview(aTableView)
        self.aScrollView.addSubview(divideLine1)
        self.view.addSubview(lastStepBtn)
        self.view.addSubview(nextStepBtn)
        self.view.addSubview(botTextLabel)
        self.view.addSubview(protocolBtn)
        
        
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
        
        topDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(topView)
        }
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 124*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 30*UIRate)
        }
        
        aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 124*UIRate + 1)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(aScrollView)
            make.height.equalTo(cellHeight)
            make.centerX.equalTo(aScrollView)
            make.top.equalTo(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.aScrollView)
            make.top.equalTo(aTableView)
        }
        
        lastStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.bottom.equalTo(self.view).offset(-10*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.right.equalTo(self.view).offset(-15*UIRate)
            make.bottom.equalTo(lastStepBtn)
        }
        
        botTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.centerX).offset(7*UIRate)
            make.bottom.equalTo(nextStepBtn.snp.top).offset(-15*UIRate)
        }
        
        protocolBtn.snp.makeConstraints { (make) in
            make.width.equalTo(75*UIRate)
            make.height.equalTo(30*UIRate)
            make.left.equalTo(self.botTextLabel.snp.right)
            make.centerY.equalTo(botTextLabel)
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
        label.text = "请上传真实资料，乱填或误填将会影响借款申请！"
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_star_15x15")
        return imageView
    }()
    
    //分割线
    private lazy var topDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
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
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_grayred_254x44"), for: .normal)
        //        button.isUserInteractionEnabled = false
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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupView = PopupPhotoSelectView()
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickCamera = {_ in //相机
            popupController.dismiss(animated: true)
        }
        popupView.onClickPhoto = { _ in //相册选取
            popupController.dismiss(animated: true)
        }
        
        popupView.onClickClose = { _ in //关闭
            popupController.dismiss(animated: true)
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
    
    ///消除手势与TableView的冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }
    
    //MARK: - Action
    func tapViewAction() {
        self.view.endEditing(true)
    }
    
    func protocolBtnAction(){
        
    }
    
    func lastStepBtnAction(){
        
    }
    
    func nextStepBtnAction(){
        
        let popupView = PopupSubmitTipsView()
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickCancle = {_ in 
            popupController.dismiss(animated: true)
        }
        popupView.onClickSure = { _ in 
            popupController.dismiss(animated: true)
        }

    }
}
