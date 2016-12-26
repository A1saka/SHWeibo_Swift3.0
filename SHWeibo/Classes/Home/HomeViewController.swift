//
//  HomeViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 21/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleBtn : TitleButton = TitleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addAnimation()
        
        // 没有登录时设置的内容
        if  !isLogin {
            return
        }
        
        // 设置导航栏
        setupNaviBar()
    }
}


extension HomeViewController{

    fileprivate func setupNaviBar() {
    
        // 设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 设置右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("LustXcc", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
        
     
    }
    

}

extension HomeViewController{

    @objc fileprivate func titleBtnClick(titleBtn: TitleButton){
        
        titleBtn.isSelected = !titleBtn.isSelected
    }

}
