//
//  UserAccount.swift
//  SHWeibo
//
//  Created by LustXcc on 21/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    // MARK:- 属性
    var access_token : String?          // 授权的AccessToken
    var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    
    }                                   // 过期时间（秒）
    var uid : String?                   // 用户ID
    var expires_date : NSDate?
    var screen_name : String?           // 昵称
    var avatar_large : String?          // 头像地址（url）
    
    
    
    // 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "avatar_large", "screen_name"]).description
    }
    
    // MARK:- 归档和解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
}
