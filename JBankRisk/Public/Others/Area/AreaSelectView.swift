//
//  AreaSelectView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AreaSelectView: UIView, UIScrollViewDelegate {

   var headTabTitle = ["请选择"]
    
    var diaries : NSArray?{
        didSet{
            self.addTableView()
        }
    }
    
    var citiesArray : NSArray?
    
    var provinceNames : [String]?{
        didSet{
            provinceListView.cityName = provinceNames!
        }
    }
    
    var cityNames : [String]?{
        didSet{
            cityoListView.cityName = cityNames!
        }
    }
    
    var districtNames : [String]?{
        didSet{
            districtListView.cityName = districtNames!
        }
    }

    
    //MARK: -生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setUp() {
        
        self.addSubview(bottomView)
        
        bottomView.addSubview(headerTabView)
        headerTabView.clickToIndex = { (index:Int) in
            self.scrollView.contentOffset = CGPoint(x:(SCREEN_WIDTH - 40*UIRate)*CGFloat(index), y: 0)
        }
        
        bottomView.addSubview(scrollView)
    }
    
    //MARK:懒加载视图
    
    private lazy var bottomView : UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 300*UIRate)
        
        return view
    }()
    
    private lazy var headerTabView : AreaSelectHeaderView = {
        let view = AreaSelectHeaderView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 50*UIRate))
        view.tabCellTitle = self.headTabTitle
        return view
    }()


    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.frame = CGRect(x: 0, y: 50*UIRate, width: SCREEN_WIDTH - 40*UIRate, height: 250*UIRate)
    
        view.isPagingEnabled = true
        view.bounces = false
        view.delegate = self
        view.contentSize = CGSize(width: (SCREEN_WIDTH - 40*UIRate)*CGFloat(self.headTabTitle.count), height: 250*UIRate)
        
        return view
    }()

    func addTableView(){
    
//       scrollView.addSubview(provinceListView)
//        provinceNames = diaries?.map({ (dic) -> String in
//            return dic["city"] as! String
//        })
    
    
    
    
    }
    
    private lazy var provinceListView : AreaTableView = {
        let view =  AreaTableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 250*UIRate))
        return view
    }()
    
    private lazy var cityoListView : AreaTableView = {
        let view =  AreaTableView(frame:CGRect(x: SCREEN_WIDTH - 40*UIRate, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 250*UIRate))
        return view
    }()
    
    private lazy var districtListView : AreaTableView = {
        let view =  AreaTableView(frame:CGRect(x: 2*(SCREEN_WIDTH - 40*UIRate), y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 250*UIRate))
        return view
    }()

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }
    
}
