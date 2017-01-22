//
//  UserAccountTool.swift
//  SHWeibo
//
//  Created by LustXcc on 22/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    // MARK:- 单例模式
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    // 定义属性
    var account: UserAccount?
    
    // 计算属性
    var accountPath: String {
        
        // 从沙盒中读取用户信息
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
        
    }
    
    var isLogin: Bool {
        if account == nil {
            return false
        }
        
        guard let expiresDate = account?.expires_date else {
            return false
        }
        
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }

 
    init() {
        
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount

    }
    
}
