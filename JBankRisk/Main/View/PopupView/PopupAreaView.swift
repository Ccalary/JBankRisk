//
//  PopupAreaView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupAreaView: UIView {

    var areaView:AreaTableView!
    
    var areaData:NSMutableDictionary!
    var disArray:NSArray!
    
    var dataArray = [String]()
    
    var provinceData = [String]()
    
    var cityData = [String]()
    var countyData = [String]()
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init() {
       let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 365*UIRate)
       self.init(frame: frame)
       let filePath = Bundle.main.path(forResource: "chinaarea", ofType: "plist")
       areaData = NSMutableDictionary(contentsOfFile: filePath!)
       disArray = areaData["Area"] as! NSArray
       
        for i in 0..<disArray.count {
            let dic: NSDictionary = disArray[i] as! NSDictionary
            let cityStr = (dic["city"] as! NSString) as String

            provinceData.append(cityStr)
        }
        
        PrintLog(provinceData)

        
       self.setupUI()
       titleLabel.text = "选择地区"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(holdView)
        self.addSubview(titleLabel)
        self.addSubview(closeBtn)
        
        self.addSubview(selectHoldView)
        self.selectHoldView.addSubview(provinceSelectBtn)
        
        self.addSubview(divideLine)
        self.addSubview(divideLine1)
        
        self.addSubview(aScrollView)
        
        holdView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
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
            make.height.equalTo(0.6*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(holdView.snp.bottom)
        }
        
        selectHoldView.snp.makeConstraints { (make) in
            make.top.equalTo(50*UIRate)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(45*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width - 40*UIRate)
            make.height.equalTo(0.6*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(selectHoldView.snp.bottom)
        }
        
        provinceSelectBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60*UIRate)
            make.height.equalTo(45*UIRate)
            make.left.equalTo(20*UIRate)
            make.centerY.equalTo(selectHoldView)
        }
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.height.equalTo(270*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(selectHoldView.snp.bottom)
        }
        aScrollView.backgroundColor = UIColor.gray
        
//        areaView = AreaTableView(dataArray: provinceData)
        self.aScrollView.addSubview(areaView)
        
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
        label.textColor = UIColorHex("666666")
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
    
    private lazy var selectHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //／按钮
    private lazy var provinceSelectBtn: UIButton = {
        let button = UIButton()
        button.setTitle("选择", for: UIControlState.normal)
        button.setTitleColor(UIColorHex("e9342d"), for: .normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.addTarget(self, action: #selector(provinceSelectBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var aScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    
     /*
     func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return dataArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "areaCellID") as! PopupStaticTableViewCell
     
     //去除选择效果
     cell.selectionStyle = .none
     cell.checkImageView.isHidden = true
     cell.leftTextLabel.textColor = UIColorHex("666666")
     
     cell.leftTextLabel.text = dataArray[indexPath.row]
     
     //        //默认选中
     //        if indexPath.row == selectedCellInfo.row {
     //            cell.checkImageView.isHidden = false
     //            cell.leftTextLabel.textColor = UIColorHex("e9342d")
     //        }else{
     //            cell.checkImageView.isHidden = true
     //            cell.leftTextLabel.textColor = UIColorHex("666666")
     //        }
     //
     //        if indexPath.row == dataArray.count - 1 {
     //            let defaultCell = IndexPath(row: selectedCellInfo.row, section: 0)
     //            self.aTableView.selectRow(at: defaultCell, animated: true, scrollPosition: UITableViewScrollPosition.none)
     //        }
     return cell
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 45*UIRate
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let cell = tableView.cellForRow(at: indexPath) as! PopupStaticTableViewCell
     cell.checkImageView.isHidden = false
     cell.leftTextLabel.textColor = UIColorHex("e9342d")
     
     self.provinceSelectBtn.setTitle(cell.leftTextLabel.text, for: .normal)
     self.provinceSelectBtn.setTitleColor(UIColorHex("666666"), for: .normal)
        
        if dataArray == cityData {
            
            let dic: NSDictionary = disArray[indexPath.row] as! NSDictionary
            let region = dic["region"] as! NSArray
            
            for i in 0..<region.count {
                
                let dic: NSDictionary = region[i] as! NSDictionary
                let area = dic["area"] as! NSArray
                for j in 0..<area.count {
                   let placeDic = area[j] as! NSDictionary
                    let place = placeDic["area"] as! String
                    countyData.append(place)
                }
                
            }
            PrintLog(countyData)
            dataArray = countyData
            self.aTableView.reloadData()
            return
        }
        
        
        let dic: NSDictionary = disArray[indexPath.row] as! NSDictionary
        let region = dic["region"] as! NSArray
        PrintLog(region)
        
        for i in 0..<region.count {
            
            let dic: NSDictionary = region[i] as! NSDictionary
            let city = (dic["region"] as! NSString) as String
            
            cityData.append(city)
        }
        PrintLog(cityData)
        dataArray = cityData
        self.aTableView.reloadData()
        
    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     
     //        let cell = tableView.cellForRow(at: indexPath) as! PopupStaticTableViewCell
     //        cell.checkImageView.isHidden = true
     //        cell.leftTextLabel.textColor = UIColorHex("666666")
     
     }
     
     //设置分割线
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
     if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
     cell.separatorInset = UIEdgeInsets(top: 0, left: 20*UIRate, bottom: 0, right: 20*UIRate)
     }
     if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
     cell.layoutMargins = UIEdgeInsets(top: 0, left: 20*UIRate, bottom: 0, right: 20*UIRate)
     }
     }
     */
     //MARK: - Action
    var onClickSelect: (()->())?
    
    //关闭
    func closeBtnAction(){
        if let onClickSelect = onClickSelect {
            onClickSelect()
        }
    }

    
    func provinceSelectBtnAction(){
        
    }
}


