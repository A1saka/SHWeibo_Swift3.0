//
//  PopoverPresentationController.swift
//  SHWeibo
//
//  Created by LustXcc on 27/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    fileprivate lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = CGRect(x:95, y:55, width:180, height:250)
        
        // 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = (containerView?.bounds)!
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
        
        
    }
    @objc fileprivate func coverViewClick() {
        
        presentedViewController.dismiss(animated: true, completion: nil)
        
    }
}
