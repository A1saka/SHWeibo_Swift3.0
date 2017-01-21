//
//  UserAccount.swift
//  SHWeibo
//
//  Created by LustXcc on 21/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    // MARK:- 属性
    var access_token : String?          // 授权的AccessToken
    var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    
    }                                   // 过期时间（秒）
    var uid : String?                   // 用户ID
    var expires_date : NSDate?
    
    
    // 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid"]).description
    }
}
