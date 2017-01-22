//
//  OAuthViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 17/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit
import AFNetworking

class OAuthViewController: UIViewController {
    
    // MARK:- 控件属性
    @IBOutlet weak var webView: UIWebView!

    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()

        let requestString: String = "https://api.weibo.com/oauth2/authorize?client_id=2875293880&redirect_uri=https://github.com/A1saka"
        let requestURL: NSURL = NSURL(string: requestString)!
        let request: NSURLRequest = NSURLRequest(url: requestURL as URL)
        webView?.loadRequest(request as URLRequest)

    }

}


// MARK:- 搭建UI界面
extension OAuthViewController {

    func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        
        title = "登录"
    }


}


// MARK:- 事件监听
extension OAuthViewController {

    @objc func closeItemClick(){
    
        dismiss(animated: true, completion: nil)
    }
    @objc func fillItemClick(){
        
        let jsCode = "document.getElementById('userId').value='2385986571@qq.com';document.getElementById('passwd').value='sc2,15271662198';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}


// MARK:- webView的delegate
extension OAuthViewController : UIWebViewDelegate {
    
    // 准备加载网页之前执行该方法
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        // 获取url中的字符串
        let urlString = url.absoluteString
        // 判断是否含有code
        guard urlString.contains("code=") else {
            return true
        }
        // 将code截取
        let code = urlString.components(separatedBy: "code=").last!
        print(code)
        loadAccessToken(code: code)
        return false
    }


}
// MARK:- 请求数据
extension OAuthViewController {
    fileprivate func loadAccessToken(code : String){
        // 获取授权access_token
        NetworkTool.shareInstance.request(requestType: .POST, url: "https://api.weibo.com/oauth2/access_token", parameters: ["client_id": "2875293880", "client_secret": "5a2587b5c53614fee25bccf84c0314a3", "grant_type" : "authorization_code", "redirect_uri" : "https://github.com/A1saka", "code" : code]) { (result, error) in
            if error !=  nil {
                print(error!)
                return
            }
            print(result!)
            guard let accountDict = result else {
                print("获取授权信息失败")
                return
            }
            // 字典 -> 模型
            let account = UserAccount(dict: accountDict)

            // 请求用户信息
            self.loadUserInfo(account: account)
        }
    
    }
    
    // 请求用户数据
    fileprivate func loadUserInfo(account: UserAccount){
        // 校验accessToken和uid
        guard let accessToken = account.access_token else {
            return
        }
        guard let uid = account.uid  else {
            return
        }
        print("授权access为：\(accessToken)uid为：\(uid)")
        // 请求url和参数
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token": accessToken, "uid": uid]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        manager.get(urlString, parameters: parameters, progress: nil, success: {  (operation, responseObject) in
            

            account.screen_name = (responseObject as! [String : AnyObject])["screen_name"] as! String?
            account.avatar_large = (responseObject as! [String : AnyObject])["avatar_large"] as! String?
            
            // 将account对象进行保存
            // 1.获取沙盒路径
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
//            print(accountPath)
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
        }) {   (operation, error) in
            print("错误信息为: \(error)")        }
    }
}



