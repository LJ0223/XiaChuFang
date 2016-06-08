//
//  ThirdHeadCollectionReusableView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/8.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class ThirdHeadCollectionReusableView: UICollectionReusableView {
    var titleLable : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layoutUIs()
    }
    
    
    func layoutUIs() {
        let leftView = UIView.init()
        leftView.frame = CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height-10)
        leftView.backgroundColor = UIColor(colorLiteralRed: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        self.addSubview(leftView)
        
        titleLable = UILabel(frame: CGRectMake(10, 10, SCREENWIDTH-10, 13))
        titleLable.text = "已上架"
        titleLable.font = UIFont.systemFontOfSize(13)
        leftView.addSubview(titleLable!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
