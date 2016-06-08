//
//  MeHeaderView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/4.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol MeHeaderViewDelegate: class {
    func meHeaderViewWorksBtnAndMenuBtnAction(sender: UIButton)
    func meHeaderViewCollectAndOrderAndDiscountAndIntegralActions(sender: UIButton)
}

class MeHeaderView: UIView {
    
    var delegate : MeHeaderViewDelegate?

    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var worksButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!

    @IBOutlet weak var selectedLab: UIView!
    @IBOutlet weak var selectedLeft: NSLayoutConstraint!
    @IBOutlet weak var selectedRight: NSLayoutConstraint!
    
    // MARK: - 收藏、订单、优惠、积分按钮点击事件
    
    @IBAction func collectionAndOrderAndDiscountAndIntegralAction(sender: UIButton) {
        if let _delegate = delegate {
            _delegate.meHeaderViewCollectAndOrderAndDiscountAndIntegralActions(sender)
        }
        
    }
    
    // MARK: - 作品、菜谱按钮点击事件
    @IBAction func headeButtonAction(sender: UIButton) {
        if sender == worksButton {
            self.selectedLeft.constant = 0
            self.selectedRight.constant = 0
            worksButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            menuButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
        } else if sender == menuButton {
            self.selectedLeft.constant = SCREENWIDTH/2
            self.selectedRight.constant = -SCREENWIDTH/2
            
            menuButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            worksButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
        
        if let _delegate = delegate {
            _delegate.meHeaderViewWorksBtnAndMenuBtnAction(sender)
        }
    }
    
    override func awakeFromNib() {
        self.headerImg.layer.masksToBounds = true
        self.headerImg.layer.cornerRadius = 40
        self.headerImg.image = UIImage(imageLiteral: "kid.jpg")
    }

}
