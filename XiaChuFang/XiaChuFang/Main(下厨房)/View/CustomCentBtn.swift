//
//  CustomCentBtn.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/25.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class CustomCentBtn: UIButton {
    
    var smallImg         : UIImageView!
    var titlLab          : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initBaseLayout()
    }
    
    func initBaseLayout() {
        smallImg = UIImageView.init(frame: CGRectMake(SCREENWIDTH/4/2-10, 20, 20, 20))
        smallImg.backgroundColor = UIColor.redColor()
        self.addSubview(smallImg)
        
        titlLab = UILabel.init(frame: CGRectMake(5, CGRectGetMaxY(smallImg.frame)+10, SCREENWIDTH/4-10, 12))
        titlLab.font = UIFont.systemFontOfSize(11)
        titlLab.textAlignment = NSTextAlignment.Center
        titlLab.textColor = XCFColor(102, g: 102, b: 102)
        self.addSubview(titlLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
