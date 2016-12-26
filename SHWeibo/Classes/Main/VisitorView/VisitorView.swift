//
//  VisitorView.swift
//  SHWeibo
//
//  Created by LustXcc on 26/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    class func visitorView() -> VisitorView {
        
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }

    
    // MARK:- 控件的属性
    @IBOutlet weak var RotaView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
 
    @IBOutlet weak var registerBtn: UIButton!
  
    @IBOutlet weak var loginBtn: UIButton!
    // MARK:- 自定义函数
    func setupVisitorViewInfo(iconName: String, title: String){
        
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        RotaView.isHidden = true
    
    }
    
    func addAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        anim.fromValue = 0
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        anim.isRemovedOnCompletion = false
        
        RotaView.layer.add(anim, forKey: nil)
    }
}
