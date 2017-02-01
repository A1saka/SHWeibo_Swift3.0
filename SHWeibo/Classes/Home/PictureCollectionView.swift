//
//  PictureCollectionView.swift
//  SHWeibo
//
//  Created by LustXcc on 01/02/2017.
//  Copyright © 2017 LustXcc. All rights reserved.
//

import UIKit

class PictureCollectionView: UICollectionView {

    // MARK:- 属性
    var pictureURLs : [URL] = [URL]() {
        
        didSet {
            self.reloadData()
        }
        
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }

}



// MARK:- DataSource
extension PictureCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PicCollectionViewCell
        
        // 2.设置cell数据
        cell.picURL = pictureURLs[indexPath.item]
        
        // 3.返回cell
        return cell
    }
}


class PicCollectionViewCell: UICollectionViewCell {
    // MARK:- 定义模型属性
    var picURL : URL? {
        
        didSet{
            guard let picURL = picURL else {
                return
            }
            iconView.sd_setImage(with: picURL, placeholderImage: UIImage(named:"empty_picture"))
        }
    }
    
    // MARK:- 控件属性
    
    @IBOutlet weak var iconView: UIImageView!
    
}
