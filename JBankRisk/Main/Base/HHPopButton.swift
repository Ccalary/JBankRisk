//
//  HHPopButton.swift
//  JBankRisk
//
//  Created by caohouhong on 17/6/2.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import pop

class HHPopButton: UIButton {
    
    var clickActionBlock: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(scaleAnimation), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scaleAnimation(){
        self.isUserInteractionEnabled = false
        
        let animation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        animation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.7, y: 0.7))
        animation?.toValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
        animation?.springBounciness = 8 //[0-20] 弹力 越大则震动幅度越大,默认为4
//        animation!.springSpeed = 20 //[0-20] 速度 越大则动画结束越快，默认12
        //以下3个与物理力学模拟相关，没特殊需求不建议使用
        //        animation.dynamicsFriction = 0 //拉力
        //        animation.dynamicsFriction = 0 //摩擦
        //        animation.dynamicsMass = 0 //质量
        
        //动画结束之后的回调方法
        animation?.completionBlock = {[weak self]  animation , isFinish in
            self?.isUserInteractionEnabled = true
            if let clickActionBlock = self?.clickActionBlock {
                clickActionBlock()
            }
        }
        self.layer.pop_add(animation, forKey: "scaleXY")
    }
}
