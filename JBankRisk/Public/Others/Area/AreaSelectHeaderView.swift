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
    
    var cellWidth : CGFloat?
    
    var cellButtons : [UIButton] = []
    
    var lastIndex : Int = 0
    
    var clickToIndex : ((Int)->())?

    //MARK: 变量
    var tabCellTitle : [String]?{
        didSet{
            cellWidth = SCREEN_WIDTH/4
            
            self.bottomIndiractor.frame = CGRect(x: 0, y: self.frame.size.height - indiractorHeight, width: cellWidth!, height: indiractorHeight)
            
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
        
        self.addSubview(bottomIndiractor)
    }
    
    private lazy var bottomIndiractor : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()

    
    func addCell() {
        for index in 0...(tabCellTitle?.count)! - 1 {
            let subButton  = UIButton()
            subButton.setTitle(tabCellTitle?[index], for: .normal)
            subButton.frame = CGRect(x: cellWidth! * CGFloat(index), y: 0, width: cellWidth!, height: self.frame.size.height)
            subButton.tag = index
            subButton.addTarget(self, action: #selector(clickCell(_:)), for: .touchUpInside)
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
