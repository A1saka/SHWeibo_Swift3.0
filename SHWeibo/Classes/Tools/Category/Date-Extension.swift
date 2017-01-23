//
//  Date-Extension.swift
//  TimeDeal
//
//  Created by LustXcc on 23/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import Foundation


extension Date {

    static func processTimeData(recevieTimeData : String) -> String {
        //  创建时间格式化对象
        let fmt = DateFormatter()
        
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        
        fmt.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        // 将字符串时间，转换为NSDate类型
        guard let  createDate = fmt.date(from: recevieTimeData) else {
            return ""
        }
    
        let currentDate = Date()
        let interval = Int(currentDate.timeIntervalSince(createDate))
        
        if interval < 60 {
            return "刚刚"
        }
        if interval < 60 * 60 {

            return "\(interval / 60)分钟前"
        }
        if interval < 60 * 60 * 24 {
            
            return "\(interval / 3600)小时前"
        }
        
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        let cmps = calendar.dateComponents([.year], from: createDate, to: currentDate)
        
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr

    }

}
