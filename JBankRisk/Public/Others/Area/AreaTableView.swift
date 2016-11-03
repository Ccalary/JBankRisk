//
//  AreaTableView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AreaTableView: UIView, UITableViewDelegate, UITableViewDataSource {

    var dataArray = [String]()
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(dataArray: Array<Any>) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 270*UIRate)
        self.init(frame: frame)
        self.dataArray = dataArray as! [String]
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PopupStaticTableViewCell.self, forCellReuseIdentifier: "areaCellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    
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
//        cell.checkImageView.isHidden = true
//        cell.leftTextLabel.textColor = UIColorHex("666666")
        cell.leftTextLabel.text = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PopupStaticTableViewCell
//        cell.checkImageView.isHidden = false
//        cell.leftTextLabel.textColor = UIColorHex("e9342d")

        
//        let dic: NSDictionary = dataArrayInfo[indexPath.row] as! NSDictionary
//        let region = dic["region"] as! NSArray
//        PrintLog(region)
//        
//        for i in 0..<dataArrayInfo.count {
//            
//            let dic: NSDictionary = dataArrayInfo[i] as! NSDictionary
//            let city = (dic["region"] as! NSString) as String
//            
//            cityData.append(city)
//        }
//        PrintLog(cityData)
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
    
    //MARK: - Action
    
    func provinceSelectBtnAction(){
        
    }

}
