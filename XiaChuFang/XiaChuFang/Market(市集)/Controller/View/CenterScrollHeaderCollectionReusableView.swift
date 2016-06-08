//
//  CenterScrollHeaderCollectionReusableView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/8.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class CenterScrollHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollArray : NSMutableArray!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let imageArray: [UIImage!] = [UIImage(named: "1111.jpg"), UIImage(named: "2222.jpg"), UIImage(named: "3333.jpg"), UIImage(named: "4444.jpg"), UIImage(named: "5555.jpg"), UIImage(named: "6666.jpg"), UIImage(named: "7777.jpg")]
        
        self.scrollArray = NSMutableArray.init(array: imageArray)
        
        
        for var index = 0; index < imageArray.count; ++index {
            let scrollImage = UIImageView.init(image: imageArray[index])
            let indexF = CGFloat(index)
            scrollImage.frame = CGRectMake(15+indexF*(80+10), 0, 80, 90)
            scrollView.addSubview(scrollImage)
        }
        
        let countF = CGFloat(imageArray.count)
//        scrollView.contentOffset = CGPointMake(20+countF*(80+10), 0)
        scrollView.contentSize = CGSizeMake(20+countF*(80+10), 0)
        scrollView.showsHorizontalScrollIndicator = false
        
    }
    
}
