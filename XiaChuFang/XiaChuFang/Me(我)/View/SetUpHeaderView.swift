//
//  SetUpHeaderView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/20.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol SetUpHeaderViewDelegate: class {
    func tapAction()
}

class SetUpHeaderView: UIView {
    
    weak var delegate: SetUpHeaderViewDelegate?

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var userTypeLab: UILabel!
    
    
    

    @IBAction func setUpHeaderViewTapAction(sender: AnyObject) {
        
        if let _delegate = delegate {
            _delegate.tapAction()
        }
        
    }
    
    
    override func awakeFromNib() {
        self.backgroundColor = XCFColor(242, g: 242, b: 242)
        
        self.userImg.layer.masksToBounds = true
        self.userImg.layer.cornerRadius = self.userImg.frame.size.width/2
        self.userImg.image = UIImage.init(named: "头像.jpg")
    }

}
