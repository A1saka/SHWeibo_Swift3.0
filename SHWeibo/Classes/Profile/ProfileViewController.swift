//
//  ProfileViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 21/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", title: "登录后，别人了评论你的微博，给你发消息，都会在这里显示")

    }

}
