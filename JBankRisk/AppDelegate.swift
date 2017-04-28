//
//  AppDelegate.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate, GuideViewDelegate {

    var window: UIWindow?
    var rootTabbar: HHTabBarController?
    
    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.0)//启动延时1秒
        
        //访问通讯录
        PPGetAddressBook.requestAddressBookAuthorization()
        
        //解决键盘遮挡问题
        IQKeyboardManager.sharedManager().enable = true
        
        //H 测试  开启ping++ 的调试打印log
        Pingpp.setDebugMode(true)
        //2.2.8 及以上版本，可选择是否在 WAP 渠道中支付完成后，点击“返回商户”按钮，直接关闭支付页面
        Pingpp.ignoreResultUrl(true)
        
        //极光推送部署
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.badge.rawValue)
        
        //H 测试 环境要改变
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: "1cbb0b714502d6add4f412ee", channel: "Publish channel", apsForProduction: JPUSH_IS_PRO) 
        
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                PrintLog("registrationID获取成功：\(registrationID)")
            }else {
                PrintLog("registrationID获取失败：\(registrationID)")
            }
        }
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        //等于1 则不是第一次，直接进入app
        if UserHelper.getIsFirstTime() == "1" {
            self.rootTabbar = HHTabBarController()
            self.rootTabbar?.delegate = self
            self.window?.rootViewController = self.rootTabbar
        }else {//是第一次打开APP－进入引导页面
            let guideVC = GuideViewController()
            guideVC.delegate = self
            self.window?.rootViewController = guideVC
            UserHelper.setIsFirstTime("1")
        }
        self.window?.makeKeyAndVisible()
        //监听网络
        self.listeningNetStatus()
        self.doWithTalkingData()
        self.doWithTencentBugly()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - Ping++
    //iOS 9.0 及以上调用
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let canHandleUrl = Pingpp.handleOpen(url, withCompletion: nil)
        return canHandleUrl
    }
    
    //iOS 8.0 及以下调用
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let canHandleUrl = Pingpp.handleOpen(url, withCompletion: nil)
        return canHandleUrl
    }
    
    //MARK: - GuideViewDelegate  引导页回调
    func enterTheApp() {
        self.rootTabbar = HHTabBarController()
        self.rootTabbar?.delegate = self
        self.window?.rootViewController = self.rootTabbar
    }
   
    //MARK: - UITabBarControllerDelegate，控制tabbar的点击
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //如果未登录
        if !UserHelper.isLogin() {
            if viewController.tabBarItem.title == "我的"{
                let loginVC = LoginViewController()
                loginVC.isPush = false
                //使登录界面的nav可以显示出来
               let loginNav = HHNavigationController(rootViewController: loginVC)
              tabBarController.selectedViewController?.present(loginNav, animated: true, completion: nil)
                return false
            }else {
                return true
            }
        }
      return true
  }
    
    //网络状态
    func listeningNetStatus(){
        self.manager?.listener = { status in
            
            switch status {
            case .unknown:
                self.rootTabbar?.showHintInKeywindow(hint: "未知网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .notReachable:
                self.rootTabbar?.showHintInKeywindow(hint: "无网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .reachable(.ethernetOrWiFi):
                self.rootTabbar?.showHintInKeywindow(hint: "WiFi连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            case .reachable(.wwan):
                self.rootTabbar?.showHintInKeywindow(hint: "数据网络连接",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
            }
        }
        self.manager?.startListening()
    }
    
    //MARK: - talkingdata 集成
    func doWithTalkingData(){
        // App ID: 在 App Analytics 创建应用后，进入数据报表页中，在“系统设置”-“编辑应用”页面里查看App ID。
        // 渠道 ID: 是渠道标识符，可通过不同渠道单独追踪数据。
        TalkingData.sessionStarted("05F6B9AFBFF24A2AA825986F102A9B6D", withChannelId: "appStore")
    }
    
    //MARK: - 腾讯Bugly
    func doWithTencentBugly(){
        // Get the default config
        let config = BuglyConfig()
        #if DEBUG
            config.debugMode = true
        #endif
        config.reportLogLevel = BuglyLogLevel.warn
        
        config.channel = "Bugly"
        Bugly.start(withAppId: "dde98fc932", config: config)
        
        Bugly.setTag(1799);
        
        Bugly.setUserIdentifier(UIDevice.current.name)
    }
}

//MARK:-极光推送
extension AppDelegate:UNUserNotificationCenterDelegate,JPUSHRegisterDelegate
{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
        JPUSHService.setTags(["user"], aliasInbackground: UserHelper.getUserId())
        PrintLog("deviceToken:\(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        PrintLog("did Fail To Register For Remote Notifications With Error:\(error)")
    }
    /**
     收到静默推送的回调
     
     @param application  UIApplication 实例
     @param userInfo 推送时指定的参数
     @param completionHandler 完成回调
     */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        PrintLog("iOS7及以上系统，收到通知:\(userInfo)")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        JPUSHService.showLocalNotification(atFront: notification, identifierKey: nil)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        
//        let request = notification.request; // 收到推送的请求
//        let content = request.content; // 收到推送的消息内容
//        
//        let badge = content.badge;  // 推送消息的角标
//        let body = content.body;    // 推送消息体
//        let sound = content.sound;  // 推送消息的声音
//        let subtitle = content.subtitle;  // 推送消息的副标题
//        let title = content.title;  // 推送消息的标题
        
         PrintLog("response:\(notification)")
        
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            PrintLog("iOS10 前台收到远程通知:\(userInfo)")
            JPUSHService.handleRemoteNotification(userInfo)
        }else {
            // 判断为本地通知
            PrintLog("iOS10 前台收到本地通知:\(userInfo)")
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.badge.rawValue))// 需要执行这个方法，选择是否提醒用户，有badge、sound、alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        
//        let request = response.notification.request; // 收到推送的请求
//        let content = request.content; // 收到推送的消息内容
//        let badge = content.badge;  // 推送消息的角标
//        let body = content.body;    // 推送消息体
//        let sound = content.sound;  // 推送消息的声音
//        let subtitle = content.subtitle;  // 推送消息的副标题
//        let title = content.title;  // 推送消息
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            PrintLog("iOS10 收到远程通知:\(userInfo)")
            let target = userInfo["target"] as? String ?? ""
            let orderId = userInfo["orderId"] as? String ?? ""
            
            self.goMessageViewController(target, andOrderId: orderId)
            
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    
    //界面跳转
    func goMessageViewController(_ withTag: String, andOrderId orderId: String){
        
        switch withTag {
        case "0"://借款状态
            let borrowStatusVC = BorrowStatusVC()
            borrowStatusVC.isPush = true
            borrowStatusVC.orderId = orderId
             let nav = HHNavigationController(rootViewController: borrowStatusVC)
            self.window?.rootViewController?.present(nav, animated: true, completion: nil);
            break
        case "2"://借款详情
            let repayVC = RepayDetailViewController()
            repayVC.orderId = orderId
            repayVC.isPush = true
            let nav = HHNavigationController(rootViewController: repayVC)
            self.window?.rootViewController?.present(nav, animated: true, completion: nil);
            break
        case "3"://有逾期去还款
            let repayVC = RepayBillSelectVC()
            repayVC.isPush = true
            let nav = HHNavigationController(rootViewController: repayVC)
            self.window?.rootViewController?.present(nav, animated: true, completion: nil);
            break
    
        default:
            break
        }
    }
}



