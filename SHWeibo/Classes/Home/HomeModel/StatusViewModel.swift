//
//  StatusViewModel.swift
//  SHWeibo
//
//  Created by LustXcc on 24/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    // MARK:- 定义属性
    var status : Status?
    
    
    // MARK:- 数据处理属性
    var sourceText : String?        // 处理来源
    var createAtText : String?      // 处理时间
    var verifiedImage : UIImage?    // 处理认证
    var vipImage : UIImage?         // 处理vip等级
    var profileURL : URL?           // 处理用户头像的url地址
    var picURLs : [URL] = [URL]()   // 处理微博配图数据
    
    
    
    // MARK:- 自定义构造函数
    init(status : Status) {
        self.status = status
        
        // 处理来源
        if let source = status.source, source != "" {
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        // 处理时间
        if let createAt = status.created_at {
        
            createAtText = Date.processTimeData(recevieTimeData: createAt)
        }
        
        // 处理认证
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        // 处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        // 用户头像url地址处理
        let profileURLString = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileURLString)
        
        //处理微博配图数据
        if let picURLsDicts = status.pic_urls {
            for picURLsDict in picURLsDicts {
                guard let picURLString = picURLsDict["thumbnail_pic"] else {
                    continue
                }
                picURLs.append(URL(string: picURLString)!)
            }
        
        }
    }
}
