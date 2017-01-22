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
    
    guard amount >= 0 else {
        return String(amount)
    }
    
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
func toolsChangeDateStyle(toMMDD time: String) -> String{
    guard time.characters.count == 8 else {
        return time
    }
    var str = time.substring(from: time.index(time.startIndex, offsetBy: 4))
    
    str.insert(".", at: str.index(str.startIndex, offsetBy: 2))
    return str
}

///日期处理--后台给的是8位数（20161112） -> 2016.11.12
func toolsChangeDateStyle(toYYYYMMDD string: String) -> String{
    guard string.characters.count == 8 else {
        return string
    }
    var time = string
    time.insert(".", at: time.index(time.startIndex, offsetBy: 4))
    time.insert(".", at: time.index(time.endIndex, offsetBy: -2))
    return time
}

///日期处理--后台给的是8位数（20161112） -> 2016.11.12
func toolsChange14DateStyle(toYYYYMMDD string: String) -> String{
    guard string.characters.count > 8 else {
        return string
    }
    var time = string.substring(to: string.index(string.startIndex, offsetBy: 8))
    time.insert(".", at: time.index(time.startIndex, offsetBy: 4))
    time.insert(".", at: time.index(time.endIndex, offsetBy: -2))
    return time
}


///日期处理--后台给的是8位数（20161112） -> 11月12日
func toolsChangeDateStyle(toMMMonthDDDay string: String) -> String {
    guard string.characters.count == 8 else {
        return string
    }
    
    let monthDayStr = string.substring(from: string.index(string.startIndex, offsetBy: 4))
    
    let monthStr = monthDayStr.substring(to: monthDayStr.index(monthDayStr.startIndex, offsetBy:2))
    let dayStr = monthDayStr.substring(from: monthDayStr.index(monthDayStr.startIndex, offsetBy:2))
    let str = "\(monthStr)月\(dayStr)日"
    return str
}

///当前时间信息
func toolsChangeCurrentDateStyle() -> String{
    
    //获得当前时间，但是时间是格林威治时间
    let currentDate = Date()  //当前时间：2016-12-07 10:00:58 +0000
    //设置时间显示样式
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current //设置时区，时间为当前系统时间
    //输出样式
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let stringDate = dateFormatter.string(from: currentDate) //转换后的当前时间：2016-12-07 18:00:58
    
    return stringDate
}

///日期处理--后台给的是全位数（20161112190000） -> 2016-11-12 19:00:00
func toolsChangeDataStyle(toFullStyle string: String) -> String{
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyyMMddHHmmss"
    let date = dateFormat.date(from: string)
    let dateMatt = DateFormatter()
    dateMatt.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let str = dateMatt.string(from: date ?? Date())
    return str
}

///日期处理--后台给的是全位数（20161112190000） -> 2016-11-12
func toolsChangeDataStyle(toDateStyle string: String) -> String{
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyyMMddHHmmss"
    let date = dateFormat.date(from: string)
    let dateMatt = DateFormatter()
    dateMatt.dateFormat = "yyyy.MM.dd"
    let str = dateMatt.string(from: date ?? Date())
    return str
}

//获取ip地址
func toolsGetIPAddresses() -> String {
    return OCTools.getIPAddress() as String
}

func toolsChangeToJson(info: Any) -> String{
    //首先判断能不能转换
    guard JSONSerialization.isValidJSONObject(info) else {
        PrintLog("json转换失败")
        return ""
    }
    //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    let jsonData = try? JSONSerialization.data(withJSONObject: info, options: [])
    
    if let jsonData = jsonData {
        let str = String(data: jsonData, encoding: String.Encoding.utf8)
        return str ?? ""
    }else {
       return ""
    }
}


