//
//  MeViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/15.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MeHeaderViewDelegate {

    @IBOutlet weak var meTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我"
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.layoutNavigationBar()
    }
    
    // MARK: - UITableViewDelegate && UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 182+44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerArray = NSArray()
        headerArray = NSBundle.mainBundle().loadNibNamed("MeHeaderView", owner: nil, options: nil)
        let sectionHeaderView = headerArray.firstObject as! MeHeaderView
        sectionHeaderView.delegate = self
        return sectionHeaderView
    }
    
    // MARK: - MeHeaderViewDelegate
    func meHeaderViewCollectAndOrderAndDiscountAndIntegralActions(sender: UIButton) {
        if sender.tag == 110 {
            // MARK: - 默认样式，注意：Swift中必须声明是iOS8.0以上才执行UIAlertController相关的代码，否则会报错
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: "收藏", message: "这个是UIAlertController的默认样式", preferredStyle: UIAlertControllerStyle.Alert)
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
            }
            
            
        } else if sender.tag == 220 {
            if #available(iOS 8.0, *) {
                // MARK: 警示样式
                let alertController = UIAlertController(title: "订单", message: "这个是UIAlertController的警示样式", preferredStyle: UIAlertControllerStyle.Alert)
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                let okAction = UIAlertAction(title: "警示", style: UIAlertActionStyle.Destructive, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
            }
            print("订单")
        } else if sender.tag == 330 {
            print("优惠")
            if #available(iOS 8.0, *) {
                // MARK: 文本对话框
                let alertController = UIAlertController(title: "优惠", message: "这个是UIAlertController的文本对话框", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
                    textField.placeholder = "登录"
                    
                    // 添加监听代码，监听文本框变化时要做的操作
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("alertTextFieldDidChange:"), name: UITextFieldTextDidChangeNotification, object: textField)
                })
                
                alertController.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
                    textField.placeholder = "密码"
                    textField.secureTextEntry = true
                })
                
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default , handler: { (action: UIAlertAction!) -> Void in
                    let login = (alertController.textFields?.first)! as UITextField
                    let password = (alertController.textFields?.last)! as UITextField
                    print("loginStr===\(login.text)，passWordStr===\(password.text)")
                    
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
                    
                })
                okAction.enabled = false
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
            }
        } else if sender.tag == 440 {
            print("积分")
            // MARK: 上拉菜单
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: "保存或删除数据", message: "删除数据将不可恢复", preferredStyle: UIAlertControllerStyle.ActionSheet)
                // 如果上拉菜单中有“取消”按钮的话，那么它永远都会出现在菜单的底部，不管添加的次序是如何（就是这么任性）。其他的按钮将会按照添加的次序从上往下依次显示
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                let deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive, handler: nil)
                let archiveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                alertController.addAction(archiveAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
            }

        }
    }
    
    // MARK: - 用户名长度超过3个字符才可以点击“好的”按钮
    func alertTextFieldDidChange(notification: NSNotification){
        if #available(iOS 8.0, *) {
            let alertController = self.presentedViewController as! UIAlertController?
            if (alertController != nil) {
                let login = (alertController!.textFields?.first)! as UITextField
                let okAction = alertController!.actions.last! as UIAlertAction
                
                if login.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 3 {
                    okAction.enabled = true
                } else {
                    okAction.enabled = false
                }
            }
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func meHeaderViewWorksBtnAndMenuBtnAction(sender: UIButton) {
        
        if sender.tag == 111 {
            print("作品")
        } else if sender.tag == 222 {
            print("菜谱")
        }
    }
    
    func layoutNavigationBar() {
//        let leftBtn = UIButton.init(frame: CGRectMake(0, 10, 20, 20))
//        leftBtn.setImage(UIImage(imageLiteral: "fenlei"), forState: UIControlState.Normal)
//        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        leftBtn.addTarget(self, action:"rightBarBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
//        let leftItem = UIBarButtonItem.init(customView: leftBtn)
//        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightBtn = UIButton.init(frame: CGRectMake(0, 10, 20, 20))
        rightBtn.setImage(UIImage(imageLiteral: "set"), forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action:"rightBarBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
   func rightBarBtnAction(sender: AnyObject) {
        let setUpController = SetUpViewController()
        self.navigationController?.pushViewController(setUpController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
