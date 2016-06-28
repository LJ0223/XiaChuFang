//
//  MarketDetailController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/27.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//


import UIKit

class MarketDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DetailMarketReusableViewDelegate {
    
    @IBOutlet weak var detailMarketCollectionView: UICollectionView!
    
    var topClassicalArray: NSMutableArray?
    var detailMarkertArray: NSMutableArray?
    
    var detailMarketTitleStr: NSString?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = detailMarketTitleStr as? String
        self.loadCollectionView()
        self.layoutNavigation()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (detailMarkertArray?.count)!
        return 10
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell: DetailMarketCell = detailMarketCollectionView.dequeueReusableCellWithReuseIdentifier("DetailMarketCellIdentifier", forIndexPath: indexPath) as! DetailMarketCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.cornerRadius = 2
        return cell

    }
    
    /*
    * 返回header的大小
    */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREENWIDTH, height: 80)
    }
    
    /*
    * 返回headview或者footview
    */
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            // 代码创建CollectionView的头视图
        let headerView:DetailMarketReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "DetailMarketReusableView", forIndexPath: indexPath) as! DetailMarketReusableView
        headerView.delegate = self
        headerView.backgroundColor = UIColor.whiteColor()

            return headerView
    }
    
    func detailMarketReusableViewSelectedWithStr(titleStr: String) {
        print("\(titleStr)")
    }

    
    func loadCollectionView() {
        // 定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout()
        // 设置cell的大小
        layout.itemSize = CGSize(width: (SCREENWIDTH-30)/2, height: (SCREENWIDTH-30)/2+50)
        // 滑动方向，默认方向是垂直方向
        layout.scrollDirection = .Vertical
        // 每个Item之间最小间距
        layout.minimumInteritemSpacing = 10
        // 每行之间最小间距
        layout.minimumLineSpacing = 10
        // 上下左右边距
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        // 定义一个UICollectionView
        detailMarketCollectionView.collectionViewLayout = layout
        detailMarketCollectionView.backgroundColor = XCFColor(242, g: 242, b: 242)
        
//        // CollectionViewCell的注册
        detailMarketCollectionView.registerNib(UINib(nibName: "DetailMarketCell", bundle: nil), forCellWithReuseIdentifier: "DetailMarketCellIdentifier")
        
        // header的注册
         detailMarketCollectionView.registerClass(DetailMarketReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DetailMarketReusableView")
    }
    
    
    func layoutNavigation() {
        let leftBtn = UIButton.init(frame: CGRectMake(10, 10, 20, 20))
        leftBtn.setImage(UIImage(imageLiteral: "back"), forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action:"leftBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
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
