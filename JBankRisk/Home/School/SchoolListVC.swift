//
//  SchoolListVC.swift
//  JBankRisk
//
//  Created by caohouhong on 17/2/6.
//  Copyright © 2017年 jingjinsuo. All rights reserved.

import UIKit

class SchoolListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var dataArray: [SchoolModel] = []
    
    //搜索结果
    var searchResultArray:[SchoolModel] = []
    
    var onClickSelect: ((_ text: String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchResultArray = dataArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - 基本UI
    func setupUI(){
        self.navigationItem.title = "选择学校"
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "请输入要搜索的学校名称"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopupStaticTableViewCell.self, forCellReuseIdentifier: "popCellID")
        
        return tableView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popCellID") as! PopupStaticTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.leftTextLabel.text = searchResultArray[indexPath.row].school_name
        cell.checkImageView.isHidden = true
        cell.leftTextLabel.textColor = UIColorHex("666666")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if let onClickSelect = self.onClickSelect {
            onClickSelect(self.searchResultArray[indexPath.row].school_name)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45*UIRate))
        headerView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            make.width.equalTo(headerView)
            make.height.equalTo(headerView)
            make.centerX.equalTo(headerView)
            make.top.equalTo(0)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45*UIRate
    }
    
    //MARK: UISearchBarDelegate
    //取消搜索
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchResultArray = dataArray
        searchBar.resignFirstResponder()
        aTableView.reloadData()
    }
    
    //关键字匹配
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //没有搜索内容则显示全部组件
        if searchText == "" {
            self.searchResultArray = dataArray
        }else { // 匹配用户输入内容
            self.searchResultArray = []
            for result in dataArray {
                if result.school_name.contains(searchText) {
                    self.searchResultArray.append(result)
                }
            }
        }
        self.aTableView.contentOffset = CGPoint(x: 0, y: 0)
        self.aTableView.reloadData()
    }
    
    //搜索按钮点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: Action
    func rightNavigationBarBtnAction(){
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
