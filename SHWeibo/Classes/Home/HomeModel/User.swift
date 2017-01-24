//
//  User.swift
//  SHWeibo
//
//  Created by LustXcc on 24/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var profile_image_url : String?     // 用户头像
    var screen_name : String?           // 用户昵称
    var verified_type : Int = -1        // 用户认证
    var mbrank : Int  = 0               // 会员等级
    
   // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
