//
//  ScreenViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/21.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController , LJAnimationViewDelegate {
    
    var backImg: UIImageView!
    var animationView = LJAnimationView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clearColor()
        
        backImg = UIImageView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT))
        backImg.image = UIImage.init(named: "LaunchImage")
        backImg.alpha = 0.4
        self.view.addSubview(backImg)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        addAnimationView()
    }
    
    func addAnimationView() {
        let size: CGFloat = 100.0
        animationView.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)
        animationView.parentFrame = view.frame
        animationView.delegate = self
        view.addSubview(animationView)
    }
    
    // MARK: -
    // MARK: AnimationViewDelegate
    func completeAnimation() {
        backImg.removeFromSuperview()
        // 1
        animationView.removeFromSuperview()
        view.backgroundColor = UIColor.colorWithHexString("#40e0b0")
        
        // 2
        let label: UILabel = UILabel(frame: view.frame)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 50.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Welcome"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,animations: ({
            
            label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
        }), completion: { finished in
            self.addTouchButton()
        })
        
    }
    
    func addTouchButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: "btnClick", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func btnClick() {
        view.backgroundColor = UIColor.whiteColor()
        view.subviews.forEach { (
            $0.removeFromSuperview()
            )}
        animationView = LJAnimationView(frame: CGRectZero)
        
        //初始化tabbar
        let tabbarVC = TabeBarViewController()
        UIApplication.sharedApplication().keyWindow?.rootViewController = tabbarVC
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

