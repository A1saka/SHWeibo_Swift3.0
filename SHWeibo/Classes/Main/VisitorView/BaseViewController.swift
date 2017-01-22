//
//  BaseViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 26/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    // MARK:- 定义变量
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    var isLogin: Bool = UserAccountViewModel.shareIntance.isLogin
    
    
    // MARK:- 系统回调函数
    override func loadView() {
        
        isLogin ? super.loadView() : setupvisitorView()
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

    // MARK:- 设置UI界面
extension BaseViewController{
    
    
    fileprivate func setupvisitorView() {

        view = visitorView
        setupNaviItem()
        
        visitorView.registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
    }
    /// 设置导航栏左右Item 
    
    fileprivate func setupNaviItem() {
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginClick))
    }
    
    
}

extension BaseViewController{

    /// Navi事件监听
    func registerClick() {
        print("注册")
    }

    func loginClick() {
        print("登录")
        let OAuthVc = OAuthViewController()
        
        let OAuthNav = UINavigationController(rootViewController: OAuthVc)
        
        present(OAuthNav, animated: true, completion: nil)
        
    }

}
