//
//  File.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/9/27.
//  Copyright © 2016年 chh. All rights reserved.
//

import UIKit

///屏幕尺寸（宽）
let SCREEN_WIDTH = UIScreen.main.bounds.width
///屏幕尺寸（高）
let SCREEN_HEIGHT = UIScreen.main.bounds.height
///适配比例
let UIRate = SCREEN_WIDTH/375.0

//顶部高度 bar + status
let TopFullHeight = StatusBarHeight + navigationBarHeight()

//status 高度
let StatusBarHeight = UIApplication.shared.statusBarFrame.height
//tabbar 高度 iPhoneX 为83
let TabBarHeight:CGFloat = StatusBarHeight > 20 ? 83 : 49
//navBar高度
func navigationBarHeight() -> CGFloat{
    let navBarHeight = UINavigationController().navigationBar.frame.size.height
    return navBarHeight
}

///RGB颜色，透明的默认为1.0
func UIColorRGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

///Hex十六进制颜色，透明度默认为1.0
func UIColorHex(_ hex: String, _ alpha: CGFloat = 1.0) -> UIColor{
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from:2) as NSString).substring(to:2)
    let bString = ((cString as NSString).substring(from:4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
}

///默认背景颜色
let defaultBackgroundColor: UIColor = UIColorHex("f3f3f3")
///默认分割线的颜色
let defaultDivideLineColor: UIColor = UIColorHex("e1e1e1")
/*
 UIColorHex("fdb300")//黄色
 UIColorHex("00b2ff")//蓝色
 UIColorHex("e9342d")//红色
 UIColorHex("666666")//黑色
 UIColorHex("c5c5c5")//浅灰色
 UIColorHex("fc4146")//红色
 UIColorHex("69D557")//绿色
 */

///字体黑色
let ColorTextBlack: UIColor = UIColorHex("666666")
let ColorTextBlue: UIColor =  UIColorHex("00b2ff")//蓝色


///系统常规字体大小
func UIFontSize(size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

///系统粗体大小
func UIFontBoldSize(size: CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: size)
}

///自定义打印日志
func PrintLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    //文件名、方法、行号、打印信息
    //        print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    print("方法:\(methodName)  行号:\(lineNumber)\n打印信息:\(message)");
}

///富文本，改变字体颜色
func changeTextColor(text: String, color: UIColor, range: NSRange) -> NSAttributedString {
    let attributeStr = NSMutableAttributedString(string: text)
    attributeStr.addAttribute(NSForegroundColorAttributeName, value:color , range: range)
    
    return attributeStr
}

///富文本，根据文字改变字体颜色
func changeSomeTextColor(text: String, inText result: String, color: UIColor) -> NSAttributedString {
    let attributeStr = NSMutableAttributedString(string: result)
    let colorRange = NSMakeRange(attributeStr.mutableString.range(of: text).location, attributeStr.mutableString.range(of: text).length)
    attributeStr.addAttribute(NSForegroundColorAttributeName, value:color , range: colorRange)
    
    return attributeStr
}

//富文本，改变字体大小
func changeTextSize(text: String, size: CGFloat, range: NSRange) -> NSAttributedString{
    let attributeStr = NSMutableAttributedString(string: text)
    attributeStr.addAttribute(NSFontAttributeName, value:size , range: range)
    return attributeStr
}

//富文本，改变字体大小和颜色
func changeTextSizeAndColor(text: String, size: CGFloat,color: UIColor, range: NSRange) -> NSAttributedString{
    let attributeStr = NSMutableAttributedString(string: text)
    attributeStr.addAttributes([NSFontAttributeName : size, NSForegroundColorAttributeName: color], range: range)
    return attributeStr
}

///改变行间距
func changeTextLineSpace(text: String, lineSpace: CGFloat = 5*UIRate) -> NSAttributedString{
    let attributeStr = NSMutableAttributedString(string: text)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpace
    attributeStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: text.characters.count))
    
    return attributeStr
}

///label高度自适应
///
/// - Parameters:
///   - text: 文字
///   - labelWidth: 最大宽度
///   - attributes: 字体，行距等
/// - Returns: 高度
func autoLabelHeight(with text:String , labelWidth: CGFloat ,attributes : [String : Any]) -> CGFloat{
    var size = CGRect()
    let size2 = CGSize(width: labelWidth, height: 0)//设置label的最大宽度
    size = text.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil);
    return size.size.height
}
