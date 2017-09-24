//
//  RepayFinalNoticeVC.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/30.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class RepayFinalNoticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let text1 = "1、提交申请后将冻结此笔借款的正常还款功能，待申请成功后可进行结算支付。"
    let text2 = "2、申请审核时间为3个自然日。"
    let text3 = "3、申请成功后需在还款截止日内一次性还款完成，还款期限为3个自然日。"
    let text4 = "4、若过时未还清结算金额，此次结算申请将作废，需以原还款计划方式进行正常还款。届时为避免出现逾期，请及时留意账单还款状态。"
    let text5 = "5、7日内有待还款的账单不能发起结算申请。"
    let text6 = "6、每笔借款的前6期还款完成才可发起账单清算。"
    let text7 = "7、若有疑问请联系客服电话400-9669-636。"
    
    let colorText = ""
    let colorText1 = "申请后将冻结此笔借款的正常还款功能"
    let colorText3 = "还款期限为3个自然日"
    let colorText4 = "过时未还清结算金额，此次结算申请将作废，需以原还款计划方式进行正常还款"
    
    var dataArray = [("","")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataArray = [(text1,colorText1), (text2,colorText), (text3,colorText3), (text4,colorText4), (text5,colorText), (text6,colorText), (text7,colorText)]
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
