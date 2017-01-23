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
    var created_at : String?  {
    
        didSet {
            guard let created_at = created_at else {
                return
            }
        createAtText = Date.processTimeData(recevieTimeData: created_at)
        }
    
    }                           // 时间
    var source : String?  {
        didSet{
            // 校验是否为空值
            guard let source = source, source != "" else {
                return
            }
            //  处理来源
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
            
            
        }
    }                           // 来源
    var text : String?          // 内容
    var mid : Int = 0           // 微博的ID

    // MARK:- 数据处理属性
    var sourceText : String?
    var createAtText : String?
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
