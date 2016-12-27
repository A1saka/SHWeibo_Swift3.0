//
//  UIBarButtonItem+Extension.swift
//  SHWeibo
//
//  Created by LustXcc on 26/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    
    
    
    convenience init(imageName : String) {
        
        
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView : btn)
    }



}
