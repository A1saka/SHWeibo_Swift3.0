//
//  NetworkTool.swift
//  NetworkTools
//
//  Created by LustXcc on 15/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import AFNetworking


enum RequestMethods : String{
    case GET = "GET"
    case POST = "POST"
}

class NetworkTool: AFHTTPSessionManager {
    // 单例
    static let shareInstance : NetworkTool = {
        let tool = NetworkTool()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
    
}


// MARK:- 封装请求方法

extension NetworkTool {
    
    // 将成功和失败的回调写在一个逃逸闭包中
    func request(requestType : RequestMethods, url : String, parameters : [String : Any], finshed : @escaping(_ result : [String : Any]?, _ error : Error?) -> ()) {
        
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, result: Any?) in
            finshed(result as! [String : Any]? , nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            finshed(nil, error)
        }
        
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    
}


