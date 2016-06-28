//
//  MarketViewController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/3/15.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MarketTopHeaderViewDelegate {

    @IBOutlet weak var marketCollectionView: UICollectionView!
    var centerImageArray : NSMutableArray?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let imageArray: [UIImage!] = [UIImage(named: "center1.jpg"), UIImage(named: "center2.jpg"), UIImage(named: "center3.jpg"), UIImage(named: "center4.jpg"), UIImage(named: "center5.jpg"), UIImage(named: "center6.jpg"), UIImage(named: "center7.jpg"), UIImage(named: "center8.jpg"), UIImage(named: "center9.jpg")]
        centerImageArray = NSMutableArray.init(array: imageArray)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.yellowColor()
        self.title = "市集"
        self.layoutNavigationBar()
        self.loadCollectionView()
    }
    
    // MARK: - UICollectionViewDelegate && UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    /*
     * section中Cell返回个数
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return (centerImageArray?.count)!
        }
        return 20
    }
    
    /*
     * Description:可以定制不同的item
     * 返回item的大小
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: SCREENWIDTH, height: 100)
        } else if indexPath.section == 2 {
            return CGSize(width: (SCREENWIDTH-30)/2, height: (SCREENWIDTH-30)/2)
        }
        return CGSize(width: 0, height: 0)
    }

    /*
     * 返回自定义Cell
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell: MarketCenterCell = marketCollectionView.dequeueReusableCellWithReuseIdentifier("MarketCenterCell", forIndexPath: indexPath) as! MarketCenterCell
            cell.centerImg.image = centerImageArray![indexPath.row] as? UIImage
            return cell
        }
        
        collectionView.registerNib(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionCell")
        let cell: MyCollectionViewCell = marketCollectionView.dequeueReusableCellWithReuseIdentifier("myCollectionCell", forIndexPath: indexPath) as! MyCollectionViewCell
        cell.titleLab.text = "\(indexPath.section):\(indexPath.row)"
        return cell
    }
    
    /*
    * 当点击某个Item之后的回应
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("(\(indexPath.section),\(indexPath.row))")
    }
    
    /*
    * 返回header的大小
    */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREENWIDTH, height: 43+100+10+80+30)
        } else if section == 1 {
            return CGSize(width: SCREENWIDTH, height: 43+100)
        }
        return CGSize(width: SCREENWIDTH, height: 43)
    }
    
    /*
     * 返回footView的Size
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: SCREENWIDTH, height: 0.000000000000000000000001)
        }
        return CGSize(width: SCREENWIDTH, height: 10)
    }
    
    /*
     * 返回headview或者footview
     */
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            if indexPath.section == 0 {
                // XIB创建CollectionView的头视图
                let topHeaderView:MarketTopHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "MarketTopHeaderView", forIndexPath: indexPath) as! MarketTopHeaderView
                topHeaderView.delegate = self
                
                return topHeaderView
            }
            
            if indexPath.section == 1 {
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CenterScrollHeaderCollectionReusableView", forIndexPath: indexPath)
                return headerView
                
            } else {
                // 代码创建CollectionView的头视图
                let headerView:ThirdHeadCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ThirdHeadCollectionReusableView", forIndexPath: indexPath) as! ThirdHeadCollectionReusableView
                headerView.backgroundColor = UIColor.whiteColor()
                return headerView
            }
        case UICollectionElementKindSectionFooter:
              // 代码创建CollectionView的尾视图
            let footer:FooterReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as!FooterReusableView
            footer.backgroundColor = UIColor(colorLiteralRed: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
            
            return footer
        default:
            return ThirdHeadCollectionReusableView()
        }
        
    }
    
    func marketTopHeaderViewAreaBtnAction() {
        print("跳转地区")
        let areaDetailController = AreaViewController()
        let areaNavController = UINavigationController.init(rootViewController: areaDetailController)
        self.navigationController?.presentViewController(areaNavController, animated: true, completion: nil)
    }
    
    func marketTopHeaderViewClassicalBtnsAction(sender: UIButton) {
        print("\(sender.titleLabel?.text)")
        let detailMarketController = MarketDetailController()
        detailMarketController.detailMarketTitleStr = sender.titleLabel?.text
        self.navigationController?.pushViewController(detailMarketController, animated: true)
    }
    
    
    func loadCollectionView() {
        // 定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout() 
        // 设置cell的大小
//        layout.itemSize = CGSize(width: 100, height: 100)
        // 滑动方向，默认方向是垂直方向
        layout.scrollDirection = .Vertical
        // 每个Item之间最小间距
//        layout.minimumInteritemSpacing = 10
        // 每行之间最小间距
        layout.minimumLineSpacing = 0
        // 上下左右边距
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        // 定义一个UICollectionView
        marketCollectionView.collectionViewLayout = layout
        marketCollectionView.backgroundColor = UIColor(colorLiteralRed: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        
        // CollectionViewCell的注册
        marketCollectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        marketCollectionView.registerNib(UINib(nibName: "MarketCenterCell", bundle: nil), forCellWithReuseIdentifier: "MarketCenterCell")
        
        // header的注册
        // Xib版header的注册
        marketCollectionView.registerNib(UINib(nibName: "MarketTopHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MarketTopHeaderView")
        marketCollectionView.registerNib(UINib(nibName: "CenterScrollHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CenterScrollHeaderCollectionReusableView")
        // 纯代码版header的注册
        marketCollectionView.registerClass(ThirdHeadCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ThirdHeadCollectionReusableView")
        // 注册footer
        marketCollectionView.registerClass(FooterReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    func layoutNavigationBar() {
        let searchBar: UISearchBar = UISearchBar(frame: CGRect.init(x: 30, y: 20, width: SCREENWIDTH-80, height: 40))
        searchBar.placeholder = "搜索商品"
        searchBar.barStyle = UIBarStyle.Default
        //        searchBar?.barTintColor = UIColor.darkGrayColor()
        searchBar.tintColor = UIColor.blackColor()
        searchBar.translucent = true
        searchBar.showsBookmarkButton = false
        searchBar.showsCancelButton = false
        searchBar.showsSearchResultsButton = false
        searchBar.showsScopeBar = false
        searchBar.showsScopeBar = false
//                searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        let leftBtn = UIButton.init(frame: CGRectMake(0, 10, 20, 20))
        leftBtn.setImage(UIImage(imageLiteral: "fenlei"), forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action:"leftBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightBtn = UIButton.init(frame: CGRectMake(0, 10, 20, 20))
        rightBtn.setImage(UIImage(imageLiteral: "gouwuche"), forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action:"leftBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }

    func leftBtnAction() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
