//
//  MainViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 21/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    
    
    fileprivate lazy var composeButton : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeButton()
    }


    
    
}


// MARK:- 设置UI界面
extension MainViewController{
    
    fileprivate func setupComposeButton(){
        
        tabBar.addSubview(composeButton)
        
        
        // 设置位置
        composeButton.center = CGPoint(x: tabBar.center.x,y :tabBar.bounds.size.height * 0.5)
        
        composeButton.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
    }
    
    
    func composeButtonClick(){
    
            print("YES")
        }



}
