//
//  ImageScroller.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/4/6.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

//属性代理
@objc protocol ImageScrollerDelegate {
    //获取所有的图片数
    func numberOfImageViewsForImageScroller(scroller: ImageScroller) -> Int
    //获取每个UIImageView
    func imageScrollerAtIndex(scroller: ImageScroller, index: Int) -> UIImageView
    //每一个图片的点击事件
    func imageScrollerClickedAtIndex(scroller: ImageScroller, index: Int)
}

class ImageScroller: UIView{
    
    weak var delegate: ImageScrollerDelegate?

    // 属性参数
    var imageViewArray = Array<UIImage>()
    var scroller: UIScrollView!
    var pageControl: UIPageControl!
    // 图片数
    private var imageCount: Int = 0
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blueColor()
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 组件一：UIScrollView的初始化
    func initializeScrollView(count: Int) {
        self.scroller = UIScrollView()
        self.scroller.delegate = self
        self.scroller.contentSize = CGSizeMake(CGFloat(count)*self.frame.width, 0)
        self.scroller.backgroundColor = UIColor.whiteColor()
        self.scroller.frame = self.bounds
        self.scroller.pagingEnabled = true
        self.scroller.bounces = false //反弹效果
        self.scroller.showsHorizontalScrollIndicator = false
        let tapRecognizer = UITapGestureRecognizer(target: self, action:Selector("scrollerTapped:"))
        self.scroller.addGestureRecognizer(tapRecognizer)
        self.addSubview(self.scroller)
    }
    
    //组件二：UIPageControl的初始化
    func initializePageControl(){
        // pageControl
        self.pageControl = UIPageControl()
        self.pageControl.center = CGPointMake(self.scroller.frame.width/2, self.scroller.frame.height-30)
        self.pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.numberOfPages = self.imageCount
        self.addSubview(pageControl)
    }
    
    // 自动滚动方法
    func autoScroll(){
        let timer = NSTimer(timeInterval: 4, target: self, selector: "scrolling", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }

    // 滚动效果设计（这里设计的比较简单）
    func scrolling() {
        var index = Int(self.scroller.contentOffset.x / self.frame.size.width)
        if index >= self.imageCount-1 {
            index = 0
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.scroller.contentOffset.x = 0
                self.pageControl.currentPage = index
            })
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.scroller.contentOffset.x = self.frame.width * (CGFloat(index) + 1)
                self.pageControl.currentPage = index + 1
            })
        }
    }
    
    //点击事件
    func scrollerTapped(gesture: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            let index = Int(self.scroller.contentOffset.x / self.frame.size.width)
            delegate.imageScrollerClickedAtIndex(self, index: index)
            self.pageControl.currentPage = index
        }
    }
    
}

//UIScrollView的拓展扩展：UIPageControl与图片联动
extension ImageScroller: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(self.scroller.contentOffset.x / self.frame.size.width)
        self.pageControl.currentPage = index
    }
}

