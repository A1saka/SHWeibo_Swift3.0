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
        
        let jsCode = "document.getElementById('userId').value='2385986571@qq.com';document.getElementById('passwd').value='scgg25655565';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}
