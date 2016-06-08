//
//  MainDetailVC.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/4/6.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class MainDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.loadCollectionView()
        
        let leftBtn = UIButton.init(frame: CGRectMake(10, 10, 20, 20))
        leftBtn.setImage(UIImage(imageLiteral: "back"), forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action:"leftBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.title = "UICollectionView Swift版"
    }
    
    func leftBtnAction() {
        print("返回返回")
        //前提：确保当前ViewController是通过NavigationController的PushView方法跳转来的
        //方式一：跳转到前一个页面
        self.navigationController?.popViewControllerAnimated(true)
        //实例化一个ViewController
        //        let firstView = FirstViewController()
        //        //方式二：返回至指定的ViewController
        //        self.navigationController?.popToViewController(viewController:  firstView , animated: true)
        //        //方式三：返回至最初的ViewController
        //        //解释：通过pushView跳转firsView->secondView->thirdView，当在thirdView执行下面语句，则调回firtView
        //        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - UICollectionViewDelegate && UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.registerNib(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionCell")
        let cell: MyCollectionViewCell = myCollectionView.dequeueReusableCellWithReuseIdentifier("myCollectionCell", forIndexPath: indexPath) as! MyCollectionViewCell
        cell.titleLab.text = "\(indexPath.section):\(indexPath.row)"
        return cell
    }
    
    /**
     - returns: 返回headview或者footview
     */
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCollectionHeaderView", forIndexPath: indexPath)
        headerView.backgroundColor = UIColor.whiteColor()
        
        return headerView
    }
    
    // #MARK: --UICollectionViewDelegate的代理方法
    /**
    Description:当点击某个Item之后的回应
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("(\(indexPath.section),\(indexPath.row))")
    }
    
    //#MARK: --UICollectionViewDelegateFlowLayout的代理方法
    /**
    - returns: header的大小
    */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREENWIDTH, height: 17)
    }
    /**
     Description:可以定制不同的item
     
     - returns: item的大小
     */
     //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     //        if  indexPath.row % 2 == 1{
     //            return CGSize(width: width/2, height: height/3)
     //        }
     //        else{
     //            return CGSize(width: width/2, height: height/2)
     //        }
     //    }
    
    
    func loadCollectionView() {
        // 定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout()
        // 设置cell的大小
        layout.itemSize = CGSize(width: 100, height: 100)
        // 滑动方向，默认方向是垂直方向
        layout.scrollDirection = .Vertical
        // 每个Item之间最小间距
        layout.minimumInteritemSpacing = 10
        // 每行之间最小间距
        layout.minimumLineSpacing = 10
        // 上下左右边距
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        // 定义一个UICollectionView
        myCollectionView.collectionViewLayout = layout
        myCollectionView.backgroundColor = UIColor.whiteColor()
        
        // CollectionViewCell的注册
        myCollectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        
        // header的注册
        myCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCollectionHeaderView")
        
        self.view.addSubview(myCollectionView)
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
