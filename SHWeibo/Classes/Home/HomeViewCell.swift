//
//  HomeViewCell.swift
//  SHWeibo
//
//  Created by LustXcc on 24/01/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15
private let imageMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {
    
    // 属性
    @IBOutlet weak var headView: UIImageView!
    @IBOutlet weak var vertifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var WeiboContent: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var PictureCollectionView: PictureCollectionView!
    
    
    @IBOutlet weak var contentLabelW: NSLayoutConstraint!
    
    @IBOutlet weak var picViewHConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var picViewWConstraint: NSLayoutConstraint!
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
            WeiboContent.text = viewModel.status?.text
            
            // 设置会员昵称文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor(red:0.961, green:0.451, blue:0.106, alpha:1)
            
            // 计算picView的宽度和高度约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWConstraint.constant = picViewSize.width
            picViewHConstraint.constant = picViewSize.height
            
            // 设置pictureCollectionView数据
            PictureCollectionView.pictureURLs = viewModel.picURLs
        }
    
    }
    
    // MARK:- 系统调用函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelW.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
        
    }

}


// MARK:- 计算宽高约束
extension HomeViewCell {
    fileprivate func calculatePicViewSize (count : Int) -> CGSize {
        // 无图
        if count == 0 {
            return CGSize.zero
        }
        // 取出图片cell的布局
        let layout = PictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 1张图
        if count == 1 {
            // 1.取出图片
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: viewModel?.picURLs.last?.absoluteString)
            // 设置一张图片时layout的itemSize
            layout.itemSize = CGSize(width: image!.size.width * 2, height: image!.size.height * 2)
            
            
            return CGSize(width: image!.size.width * 2, height: image!.size.height * 2)
        }
        // 4张图
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * imageMargin) / 3
        
        // 设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        // 4张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + imageMargin
            return CGSize(width: picViewWH, height: picViewWH)
            
        }
        // 其他数量图片
        let rows = CGFloat((count - 1) / 3 + 1)
        let picViewH = rows * imageViewWH + (rows - 1) * imageMargin
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        return CGSize(width: picViewW, height: picViewH)
        
    }

}






