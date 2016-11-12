//
//  PopupAreaView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupAreaView: UIView {

    var headTabTitle = ["请选择"]
    
    var citiesArray: NSArray?
    
    var disArray:NSArray!
    
    var dataArray = [String]()
    
    //选中的row
    var selectRow:(proRow: Int, cityRow: Int, countyRow: Int) = (-1,-1,-1)
    
    var provinceNames : [String]? = [] {
        didSet{
            provinceListView.cityName = provinceNames!
        }
    }
    
    var cityNames : [String]? = []{
        didSet{
            cityListView.cityName = cityNames!
        }
    }
    
    var districtNames : [String]? = []{
        didSet{
            districtListView.cityName = districtNames!
        }
    }

    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(proRow: Int, cityRow: Int, countyRow: Int) {
      let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 365*UIRate)
      self.init(frame: frame)
     
      self.setupUI()
      titleLabel.text = "选择地区"
      
      disArray = UserHelper.getChinaAreaInfo()
      if disArray == nil {//如果是第一次加载则存储地址
         self.storeAddress()
       }
       self.selectRow = (proRow, cityRow, countyRow)//传过来的值
       self.addTableView()
       self.clickHeaderButton()
        
       if self.selectRow.proRow >= 0 {
            self.proClick(row: self.selectRow.proRow)
            self.cityClick(row: self.selectRow.cityRow)
            self.countyClick(row: self.selectRow.countyRow)
       }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //存储地址
    func storeAddress(){
        let filePath = Bundle.main.path(forResource: "chinaarea", ofType: "plist")
        let areaData = NSMutableDictionary(contentsOfFile: filePath!)
        disArray = areaData?["Area"] as! NSArray
        UserHelper.setChinaAreaInfo(areaArray: disArray!)
    }
    
    //MARK:- 基本UI
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(holdView)
        self.addSubview(titleLabel)
        self.addSubview(closeBtn)
        
        self.addSubview(selectHoldView)
        
        self.addSubview(divideLine)
        
        self.addSubview(scrollView)
        
        self.selectHoldView.addSubview(headerTabView)
        self.selectHoldView.addSubview(divideLine1)
        
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
            make.size.equalTo(divideLine)
            make.centerX.equalTo(self)
            make.bottom.equalTo(selectHoldView.snp.bottom)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.height.equalTo(270*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(selectHoldView.snp.bottom)
        }
        scrollView.backgroundColor = UIColor.gray
        
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private lazy var headerTabView : AreaSelectHeaderView = {
        let view = AreaSelectHeaderView(frame:CGRect(x: 10*UIRate, y: 0, width: SCREEN_WIDTH - 60*UIRate, height: 45*UIRate))
        view.backgroundColor = UIColor.white
        view.tabCellTitle = self.headTabTitle
        return view
    }()
    
    private lazy var provinceListView : AreaTableView = {
        let view =  AreaTableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 270*UIRate), selectRow: -1)
        return view
    }()
    
    private lazy var cityListView : AreaTableView = {
        let view =  AreaTableView(frame:CGRect(x: SCREEN_WIDTH - 40*UIRate, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 270*UIRate), selectRow: -1)
        return view
    }()
    
    private lazy var districtListView : AreaTableView = {
        let view =  AreaTableView(frame: CGRect(x: 2*(SCREEN_WIDTH - 40*UIRate), y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 270*UIRate), selectRow: self.selectRow.countyRow)
        return view
    }()
    
    //MARK: - Method
    func addTableView(){
        
        scrollView.addSubview(provinceListView)
        
        for i in 0..<disArray!.count{
            
            let dic: NSDictionary = disArray![i] as! NSDictionary
            let city = (dic["city"] as! NSString) as String
            
            provinceNames?.append(city)
        }
        provinceListView.aTableView.reloadData()
        
        provinceListView.clickRow = { row in
            
            self.selectRow.proRow = row
            
            self.proClick(row: row)
        }
        
        cityListView.clickRow = { row in
            
            self.selectRow.cityRow = row
            
            self.cityClick(row: row)
            
        }
        districtListView.clickRow = { row in
           
            self.selectRow.countyRow = row
            self.countyClick(row: row)
            //返回地址
            if let onClickSelect = self.onClickSelect{
                onClickSelect((self.headTabTitle[0],self.selectRow.proRow),(self.headTabTitle[1],self.selectRow.cityRow),(self.headTabTitle[2],self.selectRow.countyRow))
            }
        }
    }
    
    //MARK: - 三级地址点击加载
    func proClick(row: Int){
        self.headTabTitle.removeAll()
        self.headTabTitle.append(self.provinceNames![row])
        self.headTabTitle.append("请选择")
        
        self.scrollView.addSubview(self.cityListView)
        
        let selectDic: NSDictionary = self.disArray![row] as! NSDictionary
        
        let cityArray : NSArray = (selectDic["region"]) as! NSArray
        
        self.citiesArray = cityArray
        
        for i in 0..<cityArray.count{
            let dic = cityArray[i] as! NSDictionary
            let city = (dic["region"] as! NSString) as String
            self.cityNames?.append(city)
        }
        self.cityListView.aTableView.reloadData()
        
        self.headerTabView.tabCellTitle = self.headTabTitle
        
        self.changeScrollViewSizeAndOffset()
    }
    
    func cityClick(row: Int){
        
        self.headTabTitle.removeLast()
        
        self.headTabTitle.append(self.cityNames![row])
        self.headTabTitle.append("请选择")
        self.headerTabView.tabCellTitle = self.headTabTitle
        
        self.scrollView.addSubview(self.districtListView)
        
        let selectDic: NSDictionary = self.citiesArray![row] as! NSDictionary
        
        let cityArray : NSArray = (selectDic["area"]) as! NSArray
        
        for i in 0..<cityArray.count{
            let dic = cityArray[i] as! NSDictionary
            let city = (dic["area"] as! NSString) as String
            self.districtNames?.append(city)
        }
        self.districtListView.aTableView.reloadData()
        
        self.changeScrollViewSizeAndOffset()
    }
    
    func countyClick(row: Int){
        self.headTabTitle.removeLast()
        self.headTabTitle.append(self.districtNames![row])
        self.headerTabView.tabCellTitle = self.headTabTitle
    }
    
    //点击头部按钮
    func clickHeaderButton()
    {
        headerTabView.clickToIndex = { tag in
            if tag == 1 {
                self.districtListView.removeFromSuperview()
                self.cityListView.removeFromSuperview()
                self.headTabTitle.removeLast()
                self.headTabTitle.removeLast()
                self.headTabTitle.append("请选择")
                self.headerTabView.tabCellTitle = self.headTabTitle
                self.districtNames?.removeAll()
                self.cityNames?.removeAll()
                //
                self.scrollView.addSubview(self.cityListView)
                
                let selectDic: NSDictionary = self.disArray![self.selectRow.proRow] as! NSDictionary
                
                let cityArray : NSArray = (selectDic["region"]) as! NSArray
                
                self.citiesArray = cityArray
                
                for i in 0..<cityArray.count{
                    let dic = cityArray[i] as! NSDictionary
                    let city = (dic["region"] as! NSString) as String
                    self.cityNames?.append(city)
                }
                self.cityListView.aTableView.reloadData()
                
                self.changeScrollViewSizeAndOffset()
                
            }else if tag == 0 {
                self.cityListView.removeFromSuperview()
                self.provinceListView.removeFromSuperview()
                self.headTabTitle.removeAll()
                
                if  self.headerTabView.tabCellTitle?.count == 3{
                    self.districtListView.removeFromSuperview()
                }
                self.headTabTitle.append("请选择")
                self.headerTabView.tabCellTitle = self.headTabTitle
                self.provinceNames?.removeAll()
                self.cityNames?.removeAll()
                self.districtNames?.removeAll()
                self.addTableView()
                self.changeScrollViewSizeAndOffset()
            }
        }
    }
    
    //改变scrollView
    func changeScrollViewSizeAndOffset(){
        
        self.scrollView.contentSize = CGSize(width: (SCREEN_WIDTH - 40*UIRate)*CGFloat(self.headTabTitle.count), height: 250*UIRate)
        self.scrollView.contentOffset = CGPoint(x: (SCREEN_WIDTH - 40*UIRate)*CGFloat(self.headTabTitle.count - 1), y: 0)
    }
    
    var onClickClose:(()->())?
    //返回3个元组
    var onClickSelect:(((pro:String,proRow: Int),(city:String,cityRow: Int),(county:String,countyRow: Int))->())?
    
    //关闭
    func closeBtnAction(){
        if let onClickClose = onClickClose {
            onClickClose()
        }
    }
    
   }


