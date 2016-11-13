//
//  FilterRepayView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/12.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class FilterRepayView: UIView,UITableViewDelegate, UITableViewDataSource {

    let imageData:[String] = ["m_all_image_20x20","m_payback_image_20x02","m_finish_image_20x20"]
    let textData:[String] = ["全部","待还","完成"]
    
    var onClickCell: (()->())?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 80*UIRate, height: 125*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
       self.addSubview(aTableView)
       
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(120*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(5)
        }
    }

    //图片
    private lazy var holdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image_375x220")
        return imageView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        let aImageView = UIImageView(frame: CGRect(x: 7*UIRate, y: 10*UIRate, width: 20*UIRate, height: 20*UIRate))
        aImageView.tag = 10000
        cell?.addSubview(aImageView)
        
        let aTextLabel = UILabel(frame:CGRect(x: 35*UIRate, y: 0, width: 35*UIRate, height: 40*UIRate))
        aTextLabel.font = UIFontSize(size: 15*UIRate)
        aTextLabel.tag = 10001
        aTextLabel.textColor = UIColorHex("666666")
        cell?.addSubview(aTextLabel)
        
        aImageView.image = UIImage(named: imageData[indexPath.row])
        aTextLabel.text = textData[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let onClickCell = onClickCell {
            onClickCell()
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

}
