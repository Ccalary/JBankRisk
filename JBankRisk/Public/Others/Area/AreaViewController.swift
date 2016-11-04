//
//  AreaViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {

    //MARK: 变量
    var diaryList : String?
    var data : NSMutableDictionary?
    var diaries : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        diaryList = Bundle.main.path(forResource: "chinaarea", ofType: "plist")
        data  = NSMutableDictionary(contentsOfFile:diaryList!)!
        diaries = data!.object(forKey: "Area") as? NSArray
    }
    
//    private lazy var areaSelectView : AreaSelectView = {
//        let blur = AreaSelectView()
//        blur.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
//        blur.diaries = self.diaries
//        return blur
//    }()
//    
}
