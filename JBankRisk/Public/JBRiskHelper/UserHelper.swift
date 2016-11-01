//
//  UserHelper.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class UserHelper {
    
    ///1.获得用户角色
    ///1- "学生" 2- “白领” 3-“自由族”
    static func getUserRole() -> String{
        let defaults = UserDefaults()
        return defaults.object(forKey: "userRole") as! (String)
    }
    
    ///保存用户角色
    static func setUserRole(role: String) {
        let defaults = UserDefaults()
        defaults.set(role, forKey: "userRole")
    }

}
