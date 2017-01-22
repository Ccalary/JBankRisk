//
//  RepayedSelectNameView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepayedSelectNameView: UIView, UITableViewDataSource, UITableViewDelegate {

    //默认标题为“全部纪录”
    var titleText = "全部纪录" {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    var dataArray:[JSON] = []{
        didSet{
            self.aTableView.reloadData()
        }
    }
    var onClickCell:((_ title: String,_ nameId: String)->())?
    //选中的cell
    var selectCell: Int = 0
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 4*45*UIRate)
        self.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        let indexPath = IndexPath(row: selectCell, section: 0)
        aTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        aTableView.deselectRow(at: indexPath, animated: true)
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! RepayDetailTableViewCell
        
        cell.arrowImageView.isHidden = true
        
        if indexPath.row == 0 {
            cell.textLabel?.text = titleText
        }else {
            cell.textLabel?.text = dataArray[indexPath.row - 1]["orderName"].stringValue
            
        }
        
        if indexPath.row == selectCell {
            cell.checkImage.isHidden = false
        }else {
            cell.checkImage.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectCell = indexPath.row
        self.aTableView.reloadData()
        if let onClickCell = onClickCell {
            
            if indexPath.row == 0 {
                onClickCell(titleText, "")
            }else {
                onClickCell(dataArray[indexPath.row - 1]["orderName"].stringValue, dataArray[indexPath.row - 1]["orderId"].stringValue)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
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
}
