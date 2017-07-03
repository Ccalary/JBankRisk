//
//  TimerHelper.swift
//  JBankRisk
//
//  Created by caohouhong on 17/6/15.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
//默认倒计时时间
private var defaultSeconds: Int = 60

class TimerHelper{
    var mTimer: Timer?
    var seconds: Int = defaultSeconds
    var sendCodeBtn: UIButton
    
    init(button: UIButton) {
        self.sendCodeBtn = button
    }
    
    //MARK: - Timer 默认时间60s
    func startCount(_ second: Int = defaultSeconds){
        seconds = second
        sendCodeBtn.isUserInteractionEnabled = false
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown(_:)), userInfo: nil, repeats: true)
    }
    
    func isNeedStartCount() -> Bool{
        let restTime = UserHelper.getRandomCodeRestTime()
        let times = self.intervalTime()
        return (times > restTime) ? true : false
    }
    
    //是否继续计时
    func isTimerGoOn(){
        let restTime = UserHelper.getRandomCodeRestTime()
        let times = self.intervalTime()
        if times < restTime && times > 0{
            self.startCount(restTime - times)
        }
    }
    //时间差
    private func intervalTime() -> Int{
        let timestamp = Date().timeIntervalSince1970
        let nowTime = Int(timestamp)
        let oldTime = UserHelper.getRandomCodeTimeStamp()
        let times = nowTime - oldTime
        return times
    }
    
    //时间倒计时
    @objc func countDown(_ timer: Timer){
        if seconds > 0{
            seconds -= 1
            sendCodeBtn.setTitle("\(seconds)s后重发", for: .normal)
            sendCodeBtn.setTitleColor(UIColorHex("666666"), for: .normal)
        }else if seconds == 0{
            timer.invalidate()
            seconds = defaultSeconds
            self.resetButtonState()
        }
    }
    
    private func resetButtonState(){
        sendCodeBtn.isUserInteractionEnabled = true
        sendCodeBtn.setTitle("重新发送", for: UIControlState.normal)
        sendCodeBtn.setTitleColor(UIColorHex("00b2ff"), for: .normal)
    }

    //移除计时器
    func invalidateTimer(){
        mTimer?.invalidate()
        if seconds != defaultSeconds {
            UserHelper.setRandomCodeRestTime(seconds)
            UserHelper.setRandomCodeTimeStamp()
        }
    }
}
