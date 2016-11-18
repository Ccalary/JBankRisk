//
//  Tools.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import Foundation

//137****8888--格式更改
func toolsChangePhoneNumStyle(mobile: String) -> String{
    guard mobile.characters.count == 11 else {
        return mobile
    }
    let index1 = mobile.index(mobile.startIndex, offsetBy: 3)
    let str1 = mobile.substring(to: index1)
    let index2 = mobile.index(mobile.endIndex, offsetBy: -4)
    let str2 = mobile.substring(from: index2)
    
    let newMobile = str1 + "****" + str2
    return newMobile
}
