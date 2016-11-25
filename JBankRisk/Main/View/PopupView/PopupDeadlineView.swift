//
//  PopupDeadlineView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PopupDeadlineView: UIView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var dataArray = [String]()
    var collectionHeight: CGFloat!
    var mVC: UIViewController!
    //选中的信息
    var selectInfo:(cell:Int, text:String) = (0, "")
    
    var borrowMoney = ""
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(dataArray: Array<Any>, selectedCell: Int, borrowMoney: String, mViewController:UIViewController) {
        let frame = CGRect()
        self.init(frame: frame)
        self.dataArray = dataArray as! [String]
        self.selectInfo = (selectedCell,self.dataArray[selectedCell])
        self.borrowMoney = borrowMoney
        self.mVC = mViewController
        let count:CGFloat = CGFloat((dataArray.count - 1)/3)
        collectionHeight = count*55*UIRate + 40*UIRate
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 205*UIRate + collectionHeight)
        setupUI()
        
        self.requestCalculateRepay(money: self.borrowMoney, total: self.selectInfo.text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(divideLine1)
        self.addSubview(cancelBtn)
        self.addSubview(sureBtn)
        self.addSubview(aCollectionView)
        
        self.addSubview(divideLine2)
//        self.addSubview(divideLine3)
        self.addSubview(montTextLabel)
        self.addSubview(monthMoneyLabel)
//        self.addSubview(totalTextLabel)
//        self.addSubview(totalMoneyLabel)
        self.addSubview(yuanLabel1)
//        self.addSubview(yuanLabel2)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.top).offset(25*UIRate)
            make.centerX.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self.snp.top).offset(50*UIRate)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(45*UIRate)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(cancelBtn)
            make.right.equalTo(-45*UIRate)
            make.centerY.equalTo(cancelBtn)
        }
        
//        divideLine3.snp.makeConstraints { (make) in
//            make.width.equalTo(self)
//            make.height.equalTo(0.5*UIRate)
//            make.top.equalTo(cancelBtn.snp.top).offset(-22*UIRate)
//            make.centerX.equalTo(self)
//        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(cancelBtn.snp.top).offset(-22*UIRate)
            make.centerX.equalTo(self)
        }

        montTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(35*UIRate)
            make.centerY.equalTo(divideLine2).offset(-25*UIRate)
        }
        
        monthMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(115*UIRate)
            make.centerY.equalTo(montTextLabel)
        }
        
//        totalTextLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(35*UIRate)
//            make.centerY.equalTo(divideLine3).offset(-25*UIRate)
//        }
        
//        totalMoneyLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(115*UIRate)
//            make.centerY.equalTo(totalTextLabel)
//        }
        
        yuanLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(monthMoneyLabel.snp.right)
            make.centerY.equalTo(montTextLabel)
        }
        
//        yuanLabel2.snp.makeConstraints { (make) in
//            make.left.equalTo(totalMoneyLabel.snp.right)
//            make.centerY.equalTo(totalTextLabel)
//        }
        
        aCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(270*UIRate)
            make.height.equalTo(collectionHeight)
            make.height.equalTo(95*UIRate)
            make.top.equalTo(divideLine1.snp.bottom).offset(15*UIRate)
            make.centerX.equalTo(self)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "申请期限"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80*UIRate, height: 40*UIRate)
        layout.minimumLineSpacing = 15*UIRate
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(PopupDeadlineCollectionViewCell.self, forCellWithReuseIdentifier: "deadlineCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    private lazy var montTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "月还款额"
        return label
    }()
    
    private lazy var monthMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "0.00"
        return label
    }()
    
//    private lazy var totalMoneyLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFontSize(size: 15*UIRate)
//        label.textAlignment = .center
//        label.textColor = UIColorHex("666666")
//        label.text = "0.00"
//        return label
//    }()

    private lazy var yuanLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "元"
        return label
    }()

//    private lazy var yuanLabel2: UILabel = {
//        let label = UILabel()
//        label.font = UIFontSize(size: 15*UIRate)
//        label.textAlignment = .center
//        label.textColor = UIColorHex("666666")
//        label.text = "元"
//        return label
//    }()
    
//    private lazy var totalTextLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFontSize(size: 15*UIRate)
//        label.textAlignment = .center
//        label.textColor = UIColorHex("666666")
//        label.text = "总还款额"
//        return label
//    }()
    
    ///取消按钮
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_gray_85x40"), for: .normal)
        button.setTitle("取消", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///确认按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("确认", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    //MARK: - collectionView delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deadlineCollectionCell", for: indexPath) as! PopupDeadlineCollectionViewCell
        cell.layer.cornerRadius = 4.0
        cell.textLabel.text = dataArray[indexPath.row]
        
        if indexPath.row == selectInfo.cell {
            cell.backgroundColor = UIColorHex("e9342d")
            cell.textLabel.textColor = UIColorHex("ffffff")
        }else{
            cell.backgroundColor = UIColorHex("f3f3f3")
            cell.textLabel.textColor = UIColorHex("666666")
        }
        
        if indexPath.row == dataArray.count - 1 {
            let defaultSelectCell = IndexPath(row: selectInfo.cell, section: 0)
            self.aCollectionView.selectItem(at: defaultSelectCell, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PopupDeadlineCollectionViewCell
        cell.backgroundColor = UIColorHex("e9342d")
        cell.textLabel.textColor = UIColorHex("ffffff")
        //选择的信息
        self.selectInfo = (indexPath.row, dataArray[indexPath.row])
        
        self.requestCalculateRepay(money: self.borrowMoney, total: dataArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PopupDeadlineCollectionViewCell
        cell.backgroundColor = UIColorHex("f3f3f3")
        cell.textLabel.textColor = UIColorHex("666666")
    }
    
    //MARK: - Action
    var onClickCancle : (()->())?
    var onClickSure: ((_ selectedCell: Int,_ selectStr: String,_ monthRepay: String)->())?
    
    //取消
    func cancelBtnAction(){
        if let onClickCancle = onClickCancle {
            onClickCancle()
        }
    }
    
    //确认
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure(self.selectInfo.cell, self.selectInfo.text, self.monthMoneyLabel.text!)
        }
    }
    
    //请求接口
    func requestCalculateRepay(money: String, total: String){
        let index = total.index(total.endIndex, offsetBy: -1)
        let totalStr = total.substring(to: index)
        self.mVC.showHud(in: self, hint: "正在计算...")
        var params = NetConnect.getBaseRequestParams()
        params["func"] = 3 //3固定
        params["amt"] = Double(money)
        params["total"] = totalStr
        
        NetConnect.bm_count_repayment(parameters: params, success: { response in
            self.mVC.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return
            }

        self.monthMoneyLabel.text = toolsChangeMoneyStyle(amount: json["monthAmt"].doubleValue)
            
        }, failure: { error in
            
            self.mVC.hideHud()
            
        })
    }
    

}
