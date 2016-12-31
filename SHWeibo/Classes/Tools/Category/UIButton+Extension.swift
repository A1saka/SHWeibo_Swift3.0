//
//  UIButton+Extension.swift
//  SHWeibo
//
//  Created by LustXcc on 26/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit


extension UIButton {

    // 遍历函数
    convenience init(imageName: String, bgImageName: String) {
        
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
}
