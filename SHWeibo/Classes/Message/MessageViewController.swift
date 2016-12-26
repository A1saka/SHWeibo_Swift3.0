//
//  MessageViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 21/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", title: "登录后，别人了评论你的微博，给你发消息，都会在这里显示")
    }

}
