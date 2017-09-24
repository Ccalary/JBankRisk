//
//  SelectedBillViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/7.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  账单

import UIKit
import SwiftyJSON

private let cellIdentity = "cellID"
class SelectedBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArray: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.navigationItem.title = "账单"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("00b2ff")
        
        self.view.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
        }
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(BillSelectTableViewCell.self, forCellReuseIdentifier: cellIdentity)
        
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as! BillSelectTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        cell.selectImageView.image = UIImage(named: "repay_selected_circle_20x20")
        
        cell.cellWithDate(dic: dataArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60*UIRate
    }
    
    //MARK: Action
    func rightNavigationBarBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
