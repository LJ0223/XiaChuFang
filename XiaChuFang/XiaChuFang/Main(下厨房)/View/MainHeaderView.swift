//
//  MainHeaderView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/16.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol MainHeaderViewDelegate: class {
    func mainHeaderViewTopBtnClick(title: NSString)
    func mainHeaderViewCenterBtnsClick(sender: CustomCentBtn)
}

class MainHeaderView: UIView {
    
    weak var delegate       : MainHeaderViewDelegate?
    
    /*
     * 顶部两个大按钮
     */
    var leftBtn        : UIImageView!
    var rightBtn       : UIImageView!
    var leftTitle      : UILabel!
    var rightTitle     : UILabel!
    var leftCenterImg  : UIImageView!
    var rightCenterImg : UIImageView!
    
    /*
     * 中间展示条
     */
    var BTNBASETAG     : CGFloat = 1234567
    var centerTitle    : UILabel!
    
    /*
     * 底部轮播图
     */
    var circleView     : CirCleView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
    }
    
    func leftTapAction() {
        print("左上角点击事件")
        if let _delegate = delegate {
            _delegate.mainHeaderViewTopBtnClick("left")
        }
    }
    
    func rightTapAction() {
        print("右上角点击事件")
        if let _delegate = delegate {
            _delegate.mainHeaderViewTopBtnClick("right")
        }
    }
    
    func centerBtnsTapAction(sender: CustomCentBtn) {
        print("点我了")
        if let _delegate = delegate {
            _delegate.mainHeaderViewCenterBtnsClick(sender)
        }
    }
    
    
    func initBaseLayout() {
        self.topTwoBtnLayout()
        self.centerButtonsAndTipLayout()
        self.bottomScrollLayout()
    }
    
    /*******************************  底部轮播图  **************************/
    func bottomScrollLayout() {
        let imageArray: [UIImage!] = [UIImage(named: "tx2.jpg"), UIImage(named: "tx3.jpg"), UIImage(named: "tx4.jpg")]
        
        self.circleView = CirCleView(frame: CGRectMake(0, 260, SCREENWIDTH, 80), imageArray: imageArray)
        circleView.backgroundColor = UIColor.orangeColor()
        self.addSubview(circleView)
    }
    
    /*******************************  中间区域小按钮和展示Label  **************************/
    func centerButtonsAndTipLayout() {
        let centerArray = NSMutableArray.init(array:["排行榜", "看视频", "买买买", "菜谱分类"])
        for (index, string) in centerArray.enumerate() {
            print(string)
            print(index)
            let countF = CGFloat(centerArray.count)
            let indexF = CGFloat(index)
            
            let centerBtn = CustomCentBtn.init(frame: CGRectMake(indexF*(SCREENWIDTH/countF), leftBtn.frame.size.height, SCREENWIDTH/countF, 80))
            centerBtn.backgroundColor = UIColor.whiteColor()
            centerBtn.tag = Int((indexF + 1.0) * BTNBASETAG)
            //            centerBtn.smallImg.image = UIImage(imageLiteral: "\(indexF)")
            centerBtn.titlLab.text = string as? String
            centerBtn.addTarget(self, action: "centerBtnsTapAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(centerBtn)
        }
        
        centerTitle = UILabel.init(frame: CGRectMake(0, leftBtn.frame.size.height+80, SCREENWIDTH, 50))
        centerTitle.backgroundColor = XCFColor(249, g: 241, b: 209)
        centerTitle.textColor = XCFColor(234, g: 150, b: 136)
        centerTitle.font = UIFont.systemFontOfSize(15)
        centerTitle.text = "新用户可领取20元红包"
        centerTitle.textAlignment = NSTextAlignment.Center
        self.addSubview(centerTitle)
        
    }
    
    /*******************************  顶部两个大按钮  **************************/
    func topTwoBtnLayout() {
        leftBtn = UIImageView.init(frame: CGRectMake(0, 0, SCREENWIDTH/2-1, 130))
        leftBtn.userInteractionEnabled = true
        leftBtn.backgroundColor = UIColor.cyanColor()
        self.addSubview(leftBtn)
        
        leftCenterImg = UIImageView.init(frame: CGRectMake(leftBtn.frame.size.width/2-10, leftBtn.frame.size.height/2-10, 30, 30))
        leftCenterImg.userInteractionEnabled = true
        leftCenterImg.backgroundColor = UIColor.greenColor()
        leftCenterImg.layer.cornerRadius = 15
        leftCenterImg.layer.masksToBounds = true
        leftBtn.addSubview(leftCenterImg)
        
        leftTitle = UILabel.init(frame: CGRectMake(15, leftBtn.frame.size.height-30, leftBtn.frame.size.width-25, 15))
        leftTitle.font = UIFont.systemFontOfSize(15)
        leftTitle.textColor = UIColor.whiteColor()
        leftTitle.textAlignment = NSTextAlignment.Center
        leftTitle.text = "本周流行菜谱"
        leftBtn.addSubview(leftTitle)
        
        
        rightBtn = UIImageView.init(frame: CGRectMake(leftBtn.frame.size.width+2, 0, leftBtn.frame.size.width, leftBtn.frame.size.height))
        rightBtn.userInteractionEnabled = true
        rightBtn.backgroundColor = UIColor.yellowColor()
        self.addSubview(rightBtn)
        
        rightCenterImg = UIImageView.init(frame: CGRectMake(rightBtn.frame.size.width/2-10, rightBtn.frame.size.height/2-10, 30, 30))
        rightCenterImg.userInteractionEnabled = true
        rightCenterImg.backgroundColor = UIColor.orangeColor()
        rightCenterImg.layer.cornerRadius = 15
        rightCenterImg.layer.masksToBounds = true
        rightBtn.addSubview(rightCenterImg)
        
        rightTitle = UILabel.init(frame: CGRectMake(15, leftTitle.frame.origin.y, leftBtn.frame.size.width-25, 15))
        rightTitle.font = UIFont.systemFontOfSize(15)
        rightTitle.textColor = UIColor.whiteColor()
        rightTitle.textAlignment = NSTextAlignment.Center
        rightTitle.text = "看看大家的作品"
        rightBtn.addSubview(rightTitle)
        
        
        let leftTap = UITapGestureRecognizer(target: self, action: "leftTapAction")
        leftCenterImg.addGestureRecognizer(leftTap)
        leftBtn.addGestureRecognizer(leftTap)
        
        let rightTap = UITapGestureRecognizer(target: self, action: "rightTapAction")
        rightCenterImg.addGestureRecognizer(rightTap)
        rightBtn.addGestureRecognizer(rightTap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        
//        leftBtn.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width/2, 120)
        
//        let rightBtn: UIButton?
        
    }
    
}
