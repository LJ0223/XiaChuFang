//
//  MainViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/15.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainHeaderViewDelegate, CirCleViewDelegate, UISearchBarDelegate {
    
    // 单行注释
    /*  多行注释  */
    /// 标记注释1
    /** 标记注释2 */
    
    // MARK: - 注释方法集
    // TODO: - 注释方法集
    
    var mainTable: UITableView?
    var mainArray: NSMutableArray?
    
    var headerView: MainHeaderView?
    
    var searchBar:  UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "下厨房"
        
        self.layoutNavigationBar()
        self.loadDataSource()
        self.setUpTable()
        
        print("aaaaaaaaaaaa")
    }
    
    // MARK: - tableView Delegate && tableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print(mainArray!.count)

        return (mainArray?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionArr = NSMutableArray()
        sectionArr = mainArray![section] as! NSMutableArray
        print(sectionArr.count)
        
        return sectionArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "mainCell"
        let cell = MainClassicalCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        
        //下面两个属性对应subtitle
//        cell.firstTitle?.text = mainArray![indexPath.row] as? String
//        cell.subTitle?.text = mainArray![indexPath.row] as? String
        var sectionArr = NSMutableArray()
        sectionArr = mainArray![indexPath.section] as! NSMutableArray
        
        var dic = Dictionary<String, String>()
        dic["name"] = sectionArr[indexPath.row] as? String
        cell.setValueForCell(dic)
        
        //添加照片
//        cell.showImage?.image = UIImage(named: mainArray![indexPath.row] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerArray = NSArray()
        headerArray = NSBundle.mainBundle().loadNibNamed("MainClassicalSectionHeaderView", owner: nil, options: nil)
        
        let sectionHeaderView = headerArray.firstObject as! MainClassicalSectionHeaderView

        return sectionHeaderView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000000001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 实例化一个将要跳转的viewController
        let detailVC = MainDetailVC()
        // 跳转
        self.navigationController?.pushViewController(detailVC, animated: true)
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
    
    
    // MARK:- UISearchBarDelegate
    // MARK: 输入框内容改变触发事件
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("输入框内容改变触发事件：\(searchText)")
    }
    
    // MARK: 书签按钮触发事件
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        print("搜索历史")
    }
    
    // MARK: 取消按钮触发事件
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("取消搜索")
    }

    // MARK: 搜索触发事件
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("开始搜索")
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        print("开始编辑")
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
        return false
    }
    
    // MARK:- loadDataSource
    func loadDataSource() {
        
        let path = NSBundle.mainBundle().pathForResource("mainListPlist", ofType: "plist")
        let sourceArr = NSMutableArray.init(contentsOfFile: path!)
        
        mainArray = NSMutableArray.init(array: sourceArr!)

        self.mainTable?.reloadData()
    }
    
    
    // MARK:- LayoutUIs
    
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) , style: UITableViewStyle.Grouped)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mainTable!)
        
        headerView = MainHeaderView.init(frame: CGRectMake(0, 0, SCREENWIDTH, 340))
        headerView?.delegate = self
        headerView?.circleView.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
        headerView?.circleView.delegate = self
        mainTable?.tableHeaderView = headerView
    }
    
    // MARK: SearchBar
    func layoutNavigationBar() {
        searchBar = UISearchBar(frame: CGRect.init(x: 30, y: 20, width: SCREENWIDTH-60, height: 40))
        searchBar?.placeholder = "菜谱、食材"
        searchBar?.barStyle = UIBarStyle.Default
        searchBar?.barTintColor = UIColor.darkGrayColor()
        searchBar?.tintColor = UIColor.blackColor()
        searchBar?.translucent = true
        searchBar?.showsBookmarkButton = false
        searchBar?.showsCancelButton = false
        searchBar?.showsSearchResultsButton = false
        searchBar?.showsScopeBar = false
        searchBar?.showsScopeBar = false
        searchBar?.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        var leftBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 25, height: 40))
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
