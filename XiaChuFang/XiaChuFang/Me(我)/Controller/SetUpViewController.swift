//
//  SetUpViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/20.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SetUpHeaderViewDelegate {

    @IBOutlet weak var setUpTableView: UITableView!
    var dataSource: NSMutableArray!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        dataSource = NSMutableArray.init(array: [["账号管理", "设置密码", "收货地址"], ["发现好友", "消息推送"], ["八下厨房告诉好友", "帮助下厨房评分"]])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let leftBtn = UIButton.init(frame: CGRectMake(10, 10, 20, 20))
        leftBtn.setImage(UIImage(imageLiteral: "back"), forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action:"leftBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.title = "设置"
        
        self.layoutUIs()
    }
    
    func leftBtnAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let cellArray = NSArray.init(array: self.dataSource.objectAtIndex(section) as! NSArray)
            return cellArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        }
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {        
        
        if section == 0 {
            var headerArray = NSArray()
            headerArray = NSBundle.mainBundle().loadNibNamed("SetUpHeaderView", owner: nil, options: nil)
            
            let setUpHeaderView = headerArray.firstObject as! SetUpHeaderView
            setUpHeaderView.delegate = self
            return setUpHeaderView
        } else {
            let headerView = UIView.init(frame: CGRectMake(0, 0, SCREENWIDTH, 80))
            headerView.backgroundColor = XCFColor(242, g: 242, b: 242)
            headerView.backgroundColor = XCFColor(242, g: 242, b: 242)
            return headerView
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "detailCell")
        cell.backgroundColor = UIColor.whiteColor()
        let cellArray = NSArray.init(array: self.dataSource.objectAtIndex(indexPath.section) as! NSArray)
        cell.textLabel?.text = cellArray.objectAtIndex(indexPath.row) as? String
        
        return cell
    }
    
    // MARK : - SetUpHeaderViewDelegate
    func tapAction() {
        print("点击头部跳转个人详情设置页面")
        let editVC = EditPersonalController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func layoutUIs() {
        self.setUpTableView.backgroundColor = XCFColor(242, g: 242, b: 242)
        self.setUpTableView.tableFooterView = UIView.init()
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
