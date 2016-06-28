//
//  LJPlacePickerView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/22.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol LJPlacePickerViewDelegate: class {
    func dismissPickerViewAction(button: UIButton!,  provinceStr: String?, cityStr: String?, townStr: String?)
}

class LJPlacePickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: LJPlacePickerViewDelegate?
    
    var placePicker: UIPickerView!
    var placePickerArray: NSArray?
    var provinceArray: NSArray?
    var cityArray: NSArray?
    var townArray: NSArray?
    var selectedArray: NSArray?
    
    var provinceStr: String?
    var cityStr: String?
    var townStr: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.provinceArray = NSArray()
        self.cityArray = NSArray()
        self.townArray = NSArray()
        
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.layoutPlacePickerView()
        self.getPlacePickerData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func layoutPlacePickerView() {
        
        let placeBackView: UIView = UIView.init(frame: CGRectMake(0, self.frame.size.height-300, SCREENWIDTH, 300))
        placeBackView.backgroundColor = XCFColor(242, g: 242, b: 242)
        self.addSubview(placeBackView)
        
        let cancleButton: UIButton = UIButton.init(frame: CGRectMake(15, 0, 40, 40))
        cancleButton.setTitle("取消", forState: UIControlState.Normal)
        cancleButton.setTitleColor(XCFColor(102, g: 102, b: 102), forState: UIControlState.Normal)
        cancleButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        cancleButton.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        placeBackView.addSubview(cancleButton)
        
        let titleLable: UILabel = UILabel.init(frame: CGRectMake(70, 5, SCREENWIDTH-130, 30))
        titleLable.text = "选择城市"
        titleLable.font = UIFont.systemFontOfSize(13)
        titleLable.textAlignment = NSTextAlignment.Center
        placeBackView.addSubview(titleLable)
        
        let button: UIButton = UIButton.init(frame: CGRectMake(SCREENWIDTH-50, 0, 40, 40))
        button.setTitle("完成", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        placeBackView.addSubview(button)
        
        self.placePicker = UIPickerView.init(frame: CGRectMake(0, 40, SCREENWIDTH, 260))
        self.placePicker.delegate = self
        self.placePicker.dataSource = self
        self.placePicker.backgroundColor = UIColor.whiteColor()
        self.placePicker.showsSelectionIndicator = true // 显示选中框
        //        self.placePicker.autoresizingMask = UIViewAutoresizing.FlexibleHeight |UIViewAutoresizing.FlexibleWidth //这里设置了就可以自定                                                                                                                           义高度了，一般默认是无法修改其216像素的高度
        placeBackView.addSubview(self.placePicker)
        
    }
    
    func btnAction(sender: UIButton) {
        self.removeFromSuperview()
        
        if let _delaget = delegate {
            print("省份为：\(provinceStr)")
            _delaget.dismissPickerViewAction(sender, provinceStr: self.provinceStr, cityStr: self.cityStr, townStr: self.townStr)
        }
    }
    
    // MARK: - UIPickerView Delagete
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (self.provinceArray?.count)!
        } else if component == 1 {
            return (self.cityArray?.count)!
        } else {
            return (self.townArray?.count)!
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let provinceDic:NSDictionary = NSDictionary.init(dictionary: (self.provinceArray!.objectAtIndex(row) as? NSDictionary)!)
            self.provinceStr = provinceDic.objectForKey(provinceDic.allKeys[1]) as? String
            print("row ====\(row)  省份为：\(provinceStr)")
            return self.provinceStr
        } else if component == 1 {
            let cityDic:NSDictionary = NSDictionary.init(dictionary: (self.cityArray!.objectAtIndex(row) as? NSDictionary)!)
            self.cityStr = cityDic.objectForKey(cityDic.allKeys[1]) as? String
            return cityStr
        } else {
            self.townStr = self.townArray!.objectAtIndex(row) as? String
            return self.townStr
        }
    }
    
    // 最重要的部分，实现didSelectRow()方法刷新内容，实现三级联动。类似的算法跟上面大同小异，只是调用了pickerView.reload方法，刷新component完成联动。
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let provinceDic:NSDictionary = NSDictionary.init(dictionary: (self.provinceArray!.objectAtIndex(row) as? NSDictionary)!)
            self.provinceStr = provinceDic.objectForKey(provinceDic.allKeys[1]) as? String
            print("row ====\(row)  省份为：\(provinceStr)")
            self.selectedArray = provinceDic.objectForKey(provinceDic.allKeys[0]) as? NSArray
            if self.selectedArray!.count > 0 {
                self.cityArray = self.selectedArray
            } else {
                self.cityArray = nil
            }
            if self.cityArray!.count > 0 {
                let townDic: NSDictionary = NSDictionary.init(dictionary: self.cityArray?.objectAtIndex(0) as! NSDictionary)
                self.townArray = townDic.objectForKey(townDic.allKeys[0]) as? NSArray
            } else {
                self.townArray = nil
            }
        }
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
        
        if component == 1 {
            if self.selectedArray!.count > 0 && self.cityArray!.count > 0 {
                let townDic: NSDictionary = NSDictionary.init(dictionary: self.cityArray?.objectAtIndex(row) as! NSDictionary)
                self.townArray = townDic.objectForKey(townDic.allKeys[0]) as? NSArray
            } else {
                self.townArray = nil
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
        }
        
        pickerView.reloadComponent(2)
    }
    
    // MARK: - 获取省市区字典数据源
    func getPlacePickerData() {
        self.placePickerArray = NSArray()
        let path: String = NSBundle.mainBundle().pathForResource("area.plist", ofType:nil)!
        self.placePickerArray = NSArray(contentsOfFile: path)
        self.provinceArray = self.placePickerArray
        self.selectedArray = self.provinceArray
        
        if self.selectedArray?.count > 0 {
            let cityDic: NSDictionary = NSDictionary.init(dictionary: self.selectedArray?.objectAtIndex(0) as! NSDictionary)
            self.cityArray = cityDic.objectForKey(cityDic.allKeys[0]) as? NSArray
        }
        
        if self.cityArray?.count > 0 {
            let townDic: NSDictionary = NSDictionary.init(dictionary: self.cityArray?.objectAtIndex(0) as! NSDictionary)
            self.townArray = townDic.objectForKey(townDic.allKeys[0]) as? NSArray
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
}
