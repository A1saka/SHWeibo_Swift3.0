//
//  OAuthViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 17/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

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
        NetworkTool.shareInstance.request(requestType: .POST, url: "https://api.weibo.com/oauth2/access_token", parameters: ["client_id": "2875293880", "client_secret": "3a71507008d2b536062828db65521b3e", "grant_type" : "authorization_code", "redirect_uri" : "https://github.com/A1saka", "code" : code]) { (result, error) in
            if error !=  nil {
                print(error!)
                return
            }
            print(result!)
        }
    
    }

}
