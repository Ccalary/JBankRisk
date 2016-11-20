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

///金额显示加逗号(,)分隔
func toolsChangeMoneyStyle(amount: Double) -> String{
    
    //初始化NumberFormatter
    let format = NumberFormatter()
    //设置numberStyle（有多种格式）
    format.numberStyle = .currency //格式¥122,222.22
    
    //转换后的string
    let  string = format.string(from: NSNumber(value: amount))
   
    let index = string?.index((string?.startIndex)!, offsetBy: 1)
    let str = string?.substring(from: index!)
    
    if let str = str {
         return str
    }else {
        return  String(amount)
    }
}

//剔除逗号
func toolsDeleteSymbol(with string: String?) -> String {
    var result = string
    if result?.range(of: ",") != nil {
         result = result?.replacingOccurrences(of: ",", with: "")
    }
    return result ?? ""
}

///日期处理--后台给的是8位数（20161112） -> 11.12
func toolsChangeDateStyleToMMDD(time: String) -> String{
    guard time.characters.count == 8 else {
        return time
    }
    var str = time.substring(from: time.index(time.startIndex, offsetBy: 4))
    
    str.insert(".", at: str.index(str.startIndex, offsetBy: 2))
    return str
}

///日期处理--后台给的是8位数（20161112） -> 2016.11.12
func toolsChangeDateStyleToYYYYMMDD(string: String) -> String{
    guard string.characters.count == 8 else {
        return string
    }
    var time = string
    time.insert(".", at: time.index(time.startIndex, offsetBy: 4))
    time.insert(".", at: time.index(time.endIndex, offsetBy: -2))
    return time
}






