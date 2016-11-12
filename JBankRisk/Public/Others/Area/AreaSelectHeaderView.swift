//
//  AreaSelectHeaderView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AreaSelectHeaderView: UIView {

    let indiractorHeight = 2*UIRate
    
    var cellWidth : CGFloat = SCREEN_WIDTH/4.0
    
    var cellButtons : [UIButton] = []
    
    var lastIndex : Int = 0
    
    var clickToIndex : ((Int)->())?

    //MARK: 变量
    var tabCellTitle : [String]?{
        didSet{
           
            UIView.animate(withDuration: 0.5, animations: {
                self.bottomIndiractor.frame = CGRect(x: self.cellWidth*CGFloat((self.tabCellTitle?.count)! - 1), y: self.frame.size.height - self.indiractorHeight, width: self.cellWidth, height: self.indiractorHeight)
                })
            self.removeCell()
            self.addCell()
        }
    }
    //MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        self.backgroundColor = UIColor.white
        
        bottomIndiractor.frame = CGRect(x: 0, y: self.frame.size.height - self.indiractorHeight, width: self.cellWidth, height: self.indiractorHeight)
        self.addSubview(bottomIndiractor)
        
    }
    
    private lazy var bottomIndiractor : UIView = {
        let view = UIView()
        view.backgroundColor = UIColorHex("e9342d")
        return view
    }()
    
    func addCell() {
        for index in 0...(tabCellTitle?.count)! - 1 {
            let subButton  = UIButton()
            subButton.setTitle(tabCellTitle?[index], for: .normal)
            subButton.frame = CGRect(x: cellWidth * CGFloat(index), y: 0, width: cellWidth, height: self.frame.size.height)
            subButton.tag = index
            subButton.addTarget(self, action: #selector(clickCell(_:)), for: .touchUpInside)
            //改变显示的颜色
            if tabCellTitle?[index] == "请选择"{
                subButton.setTitleColor(UIColorHex("e9342d"), for: .normal)
            }else{
                subButton.setTitleColor(UIColorHex("666666"), for: .normal)
            }
            //如果是最后一个button则点击无效
            if (index == (tabCellTitle?.count)! - 1) {
                subButton.isUserInteractionEnabled = false
            }else {
                subButton.isUserInteractionEnabled = true
            }
            self.addSubview(subButton)
            cellButtons.append(subButton)
        }
    }
    
    func removeCell(){
        for button in cellButtons {
            button.removeFromSuperview()
        }
        cellButtons.removeAll()
    }
    
    func clickCell(_ cell:UIButton){
        let tagIndex = cell.tag
        
        if let clickToIndex = clickToIndex {
            clickToIndex(tagIndex)
        }
    }
    
}
