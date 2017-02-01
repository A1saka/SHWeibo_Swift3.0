//
//  Status.swift
//  SHWeibo
//
//  Created by LustXcc on 23/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class Status: NSObject {
    // MARK:- 属性
    var created_at : String?    // 时间
    var source : String?        // 来源
    var text : String?          // 内容
    var mid : Int = 0           // 微博的ID
    
    var user : User?
    var pic_urls : [[String : String]]? // 微博配图
    var retweeted_status : Status? // 转发微博
    
  
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        // 用户字典 -> 用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
        // 转发微博的字典 -> 转发微博的模型对象
        if let retweetStatusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = Status(dict: retweetStatusDict)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
