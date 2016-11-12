//
//  AreaTableView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AreaTableView: UIView, UITableViewDelegate, UITableViewDataSource {

    var cityName = [String]()
    
    var clickRow:((_ row:Int)->())?
    
    var selectedCell:Int = -1
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
    }
    
    ///初始化默认frame
    convenience init(frame: CGRect,selectRow: Int){
         self.init(frame: frame)
         self.selectedCell = selectRow
         self.setupUI()
        
//        //默认选中的cell(有问题，崩溃)
//        if selectedCell >= 0 {
//            let defaultCell = IndexPath(row: 6, section: 0)
//            self.aTableView.selectRow(at: defaultCell, animated: true, scrollPosition: UITableViewScrollPosition.top)
//        }
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
    
   lazy var aTableView: UITableView = {
        
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
        return cityName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaCellID") as! PopupStaticTableViewCell
        //去除选择效果
      cell.backgroundColor = UIColor.white
      cell.selectionStyle = .none
      cell.leftTextLabel.text = cityName[indexPath.row]
        
        //默认选中
        if indexPath.row == selectedCell {
            cell.checkImageView.isHidden = false
            cell.leftTextLabel.textColor = UIColorHex("e9342d")
        }else{
            cell.checkImageView.isHidden = true
            cell.leftTextLabel.textColor = UIColorHex("666666")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let clickRow = clickRow {
            clickRow(indexPath.row)
        }
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
    
}
