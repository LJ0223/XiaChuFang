//
//  MainViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/15.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainHeaderViewDelegate, CirCleViewDelegate {
    
    // 单行注释
    /*  多行注释  */
    /// 标记注释1
    /** 标记注释2 */
    
    // MARK: - 注释方法集
    // TODO: - 注释方法集
    
    var mainTable: UITableView?
    var mainArray: NSMutableArray?
    
    var headerView: MainHeaderView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "下厨房"
        
        self.setUpTable()
        self.loadDataSource()
        
        print("aaaaaaaaaaaa")
    }
    
    // MARK: - tableView Delegate && tableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(mainArray!.count)
        return mainArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "mainCell"
        let cell = MainClassicalCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        
        //下面两个属性对应subtitle
//        cell.firstTitle?.text = mainArray![indexPath.row] as? String
//        cell.subTitle?.text = mainArray![indexPath.row] as? String
        
        var dic = Dictionary<String, String>()
        dic["name"] = mainArray![indexPath.row] as? String
        cell.setValueForCell(dic)
        
        //添加照片
//        cell.showImage?.image = UIImage(named: mainArray![indexPath.row] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = MainHeaderView.init(frame: CGRectMake(0, 0, SCREENWIDTH, 340))
        headerView?.delegate = self
        headerView?.circleView.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
        headerView?.circleView.delegate = self
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 340
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000000001
    }
    
    
    // MARK:- MainHeaderViewDelegate 协议方法
    // MARK:  MainHeaderView顶部两个大按钮的点击事件
    func mainHeaderViewTopBtnClick(title: NSString) {
        print("title====\(title)")
        if title.isEqualToString("left") {
            // MainHeaderView左上角点击事件
            print("MainHeaderView左上角点击事件")
        } else {
            // MainHeaderView右上角点击事件
            print("MainHeaderView右上角点击事件")
        }
    }
    
    // MARK:  MainHeaderView中间四个小按钮的点击事件
    func mainHeaderViewCenterBtnsClick(sender: CustomCentBtn) {
        print("centerBtn.title====\(sender.titlLab.text)")
    }
    
    // MARK:-  MainHeaderView底部轮播图点击事件
    func clickCurrentImage(currentIndxe: Int) {
        print("选中图片下标====\(currentIndxe)")
    }
    
    
    func loadDataSource() {
        mainArray = NSMutableArray.init(array: ["宝宝0", "宝宝1", "宝宝2", "宝宝3", "宝宝4", "宝宝5", "宝宝6", "宝宝7", "宝宝8", "宝宝9", "宝宝10", "宝宝11"])

        self.mainTable?.reloadData()
    }
    
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) , style: UITableViewStyle.Grouped)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mainTable!)
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
