//
//  CancelOrderNoticeVC.swift
//  JBankRisk
//
//  Created by chh on 2017/9/14.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class CancelOrderNoticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let text1 = "1、提交申请后将冻结此笔借款的正常还款功能，待申请成功后可进行结算支付。"
    let text2 = "2、申请后需在24小时内支付违约金。若过时未支付，此次撤销借款申请将作废，需以原还款计划进行正常还款。届时为避免出现逾期，请及时留意帐单还款状态。"
    let text3 = "3、2日内有待还款的账单不能发起撤销申请。"
    let text4 = "4、若有疑问请联系客服电话400-9669-636。"
    
    let colorText = ""
    let colorText1 = "申请后将冻结此笔借款的正常还款功能"
    let colorText2 = "需在24小时内支付违约金"
    
    var dataArray = [("","")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = [(text1,colorText1), (text2,colorText2), (text3,colorText), (text4,colorText)]
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        
        self.navigationItem.title = "注意事项"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(5)
        }
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(RFNoticeTableViewCell.self, forCellReuseIdentifier:cellID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! RFNoticeTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        cell.leftLabel.attributedText = changeSomeTextColor(text: dataArray[indexPath.row].1, inText: dataArray[indexPath.row].0, color: ColorTextBlue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let attibute = [NSFontAttributeName:UIFontSize(size: 15*UIRate)]
        let height = autoLabelHeight(with: dataArray[indexPath.row].0, labelWidth: SCREEN_WIDTH - 30*UIRate, attributes: attibute)
        
        return height + 15*UIRate
    }
}
