//
//  HomeViewCell.swift
//  SHWeibo
//
//  Created by LustXcc on 24/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {
    
    // 属性
    @IBOutlet weak var headView: UIImageView!
    @IBOutlet weak var vertifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var WeiboContent: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var contentLabelW: NSLayoutConstraint!
    
    
    // MARK:- 自定义属性
    var viewModel : StatusViewModel? {
        didSet {
            // 判断是否为空值
            guard let viewModel = viewModel else {
                return
            }
            
            headView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            vertifiedView.image = viewModel.verifiedImage
            screenNameLabel.text = viewModel.status?.user?.screen_name
            vipView.image = viewModel.vipImage
            timeLabel.text = viewModel.createAtText
            sourceLabel.text = viewModel.status?.text
            
        }
    
    }
    
    // MARK:- 系统调用函数
    override func awakeFromNib() {
        super.awakeFromNib()
   
        contentLabelW.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
    }

}
