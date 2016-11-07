//
//  HomeViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  首页

import UIKit
import SnapKit

let homeCellID = "HomeTableViewCell"

class HomeViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var bannerView: CyclePictureView! //图片轮播
    var imageArray: NSMutableArray? //储存所有照片
    var urlArray: NSMutableArray? //存储地址
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //启动滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //初始化图片数据
        imageArray = NSMutableArray()
        urlArray = NSMutableArray()
        
        
        initBannerImage()
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }

    
    //基本设置
    func setup(){
        
        self.view.addSubview(aTableView)
        aTableView.snp.makeConstraints { (mark) in
            mark.width.equalTo(self.view)
            mark.height.equalTo(SCREEN_HEIGHT - 220*UIRate - 100)
            mark.top.equalTo(bannerView.snp.bottom)
        }
    }
    
   private lazy var aTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellID)
        
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    //MARK: - 初始化banner轮播图
    func initBannerImage(){
        
        //添加数据
        let array = [    ["image":"http://pic.zsucai.com/files/2013/0814/xychh1.jpg","url":"http://www.swift51.com/swift.html"],["image":"http://dfzy.ggjy.net/ziran/UploadSoftPic/200705/20070511100822129.jpg","url":"https://www.baidu.com"]]
        /*,
         ["image":"http://pic2.52pk.com/files/120116/801441_153023_4787.jpg","url":"http://cn.bing.com"],
         ["image":"http://img5q.duitang.com/uploads/item/201411/21/20141121230440_yBssa.jpeg","url":"https://www.yahoo.com"], ["image":"http://img04.tooopen.com/images/20130916/sy_41580784261.jpg","url":"https://www.so.com"],
         ["image":"http://e-lvyou.com/admin/Upload_mp_pic/2014316175741877.jpg","url":"http://gold.xitu.io/explore/all"],*/
        
        for item in array {
            imageArray?.add(item["image"]!)
            urlArray?.add(item["url"]!)
        }
        
        //图片轮播
        bannerView = CyclePictureView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 220*UIRate), imageArray:imageArray!)
        bannerView.delegate = self
        self.view.addSubview(bannerView)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource,CyclePictureViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! HomeTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.leftImageView.image = UIImage(named: "home_loan_icon_50x50")
            cell.topTextLabel.text = "贷动美丽 化茧伊人"
            cell.bottomTextLabel.text = "0首付，期限长"
            cell.rightTextLabel.text = "我要借款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 1:
            cell.leftImageView.image = UIImage(named: "home_progress_icon_50x50")
            cell.topTextLabel.text = "查看申请进度"
            cell.bottomTextLabel.text = "实时了解，一手掌握"
            cell.rightTextLabel.text = "进度查询"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 2:
            cell.leftImageView.image = UIImage(named: "home_repayment_icon_50x50")
            cell.topTextLabel.text = "还款详情"
            cell.bottomTextLabel.text = "当前无可还款"
            cell.rightTextLabel.text = "我要还款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let popupView =  PopupSelectRoleView(currentIndex: -1)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.theme.presentationStyle = .slideInFromRight
            popupController.theme.dismissesOppositeDirection = false
            popupController.present(animated: true)
            popupView.onClickCloseBtn = { _ in
               popupController.dismiss(animated: true)
            }
            popupView.onClickSelect = { role in
                popupController.dismiss(animated: true)
                UserHelper.setUserRole(role: role.rawValue)
                let loginVC = BorrowMoneyViewController()
                self.navigationController?.pushViewController(loginVC, animated: false)
            }
        case 1:
//            let registerVC = DataViewController(roleType: .worker)
//            self.navigationController?.pushViewController(registerVC, animated: true)
//
            let phoneCallView = PopupAreaView()
            let popupController = CNPPopupController(contents: [phoneCallView])!
            popupController.present(animated: true)
            phoneCallView.onClickSelect = {_ in
                popupController.dismiss(animated: true)
            }
            break
        case 2:
            let registerVC = RepayDetailViewController()
            self.navigationController?.pushViewController(registerVC, animated: true)
        default:
            break
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
    
    //MARK: - CyclePictureViewDelegate的方法
    func cyclePictureSkip(To index: Int) {
        let bannerUrlVC = BaseWebViewController()
        bannerUrlVC.requestUrl = self.urlArray?[index] as? String
        self.navigationController?.pushViewController(bannerUrlVC, animated: false
        )
    }
}
