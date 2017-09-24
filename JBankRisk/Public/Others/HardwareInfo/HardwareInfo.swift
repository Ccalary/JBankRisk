//
//  HardwareInfo.swift
//  JBankRisk
//
//  Created by chh on 2017/9/20.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  获取硬件信息

import UIKit
import CoreTelephony

class HardwareInfo {

    struct Platform {
        static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
    }
    
    var iphoneType = ""    //手机型号
    var name = ""          //设备名称
    var systemName = ""    //当前运行的系统
    var systemVersion = "" //系统版本
    var identifier = ""    //唯一标识符
    
    var carrierName = ""   //运营商
    var isBreakOut = false //是否越狱
    var isSimulator = false //是否是模拟器
    var netStatus = ""      //网络状态
    
    var batteryState = ""   //电池状态
    var batteryLevel: Float = 0.0  //电池等级
    var totalMemorySize: UInt64 = 0   //总内存大小
    var availableMemorySize: UInt64 = 0 //可用内存大小
    var usedMemory: Double = 0.0   //已使用内存
    
    init() {
        
    }
    
    func deviceInfo(){
        
        iphoneType = OCTools.getIPhoneType()
        
        let device = UIDevice.current
        //设备名
        name = device.name
        systemName = device.systemName
        systemVersion = device.systemVersion
        identifier = device.identifierForVendor?.uuidString ?? ""
        
        //运营商
        let telephonyInfo = CTTelephonyNetworkInfo()
        let carrier = telephonyInfo.subscriberCellularProvider
        carrierName = carrier?.carrierName ?? ""
        
        //是否越狱
        isBreakOut = self.isBreakOutPrison()
        //是否模拟器
        isSimulator = Platform.isSimulator
        //网络状态
        netStatus = UserHelper.getNetStatus()
        //电池状态
        batteryState = self.getBatteryState()
        //电池等级
        batteryLevel = device.batteryLevel
        //总内存
        totalMemorySize = self.getTotalMemorySize()
        //可用内存
        availableMemorySize = UInt64(OCTools.getAvailableMemorySize())
        //已用内存
        usedMemory = OCTools.getUsedMemory()
    }
    
    //是否越狱
    private func isBreakOutPrison() -> Bool {

        //根据是否可以读到手机里的所有应用判断
        let fileExists = FileManager.default.fileExists(atPath: "/User/Applications/")
        
        return fileExists
    }
    
    //电池状态，共4种状态
    private func getBatteryState() -> String{
        let device = UIDevice.current
        switch device.batteryState {
        case .unknown:
            return "UnKnow"
        case .unplugged:
            return "UnPlugged"
        case .charging:
            return "Charging"
        case .full:
            return "full"
        }
    }
    
    //总内存
    private func getTotalMemorySize() -> UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    
    //上传硬件信息
    func uploadHardwareInfo(){
        
        var params = NetConnect.getBaseRequestParams()
        
        
        NetConnect.other_upload_hardware_info(parameters: params, success: { response in
            
        }, failure:{ error in
  
        })
    }
}
