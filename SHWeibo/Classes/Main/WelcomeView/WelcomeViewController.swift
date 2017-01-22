//
//  WelcomeViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 22/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var headView: UIImageView!
    
    @IBOutlet weak var iconViewBottomConstraint: NSLayoutConstraint!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileString = UserAccountViewModel.shareIntance.account?.avatar_large
        let url = URL(string: profileString ?? "")
        
        headView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        // 改变距离底部约束的大小
        iconViewBottomConstraint.constant = UIScreen.main.bounds.height - 200
        
        // 执行动画
       UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { 
        self.view.layoutIfNeeded()
       }, completion: { (_) in
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
       })
    }

}
