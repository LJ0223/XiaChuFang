//
//  LJDatePickerView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/22.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol LJDatePickerViewDelegate: class {
    func LJDatePickerViewFinishAction(sender: UIButton, dateStr: String)
}

class LJDatePickerView: UIView {
    
    weak var delegate: LJDatePickerViewDelegate?

    var beginTime :  NSString?
    var endTime   :  NSString?
    
    var datePicker: UIDatePicker?
    
    var minDate: NSDate?
    var maxDate: NSDate?
    var dateFormat: NSDateFormatter = NSDateFormatter()
    
    var selectedDate: NSDate?
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        
         // 时间显示格式
        dateFormat.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormat.dateFormat = "yyyy-MM-dd"
        //            dateFormat.timeStyle = NSDateFormatterStyle.LongStyle
        
        self.createDatePicker()
    }
    
    func createDatePicker() {
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
        titleLable.text = "选择出生日期"
        titleLable.font = UIFont.systemFontOfSize(13)
        titleLable.textAlignment = NSTextAlignment.Center
        placeBackView.addSubview(titleLable)
        
        let button: UIButton = UIButton.init(frame: CGRectMake(SCREENWIDTH-50, 0, 40, 40))
        button.setTitle("完成", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        placeBackView.addSubview(button)

        
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 40, SCREENWIDTH, 260))
        // 将日期选择器区域设置为中文，则选择器日期显示为中文
        self.datePicker?.locale = NSLocale(localeIdentifier: "zh_CN")
        
        // 日期模式，默认年月日时分秒 设置后为年月日
        self.datePicker?.datePickerMode = UIDatePickerMode.Date
        
        // 设置最大最小时间
        let maxDate = dateFormat.dateFromString("2016-06-25")
        let minDate = dateFormat.dateFromString("1980-01-01")
        self.datePicker!.maximumDate = maxDate
        self.datePicker!.minimumDate = minDate        // 设置默认时间        
        self.datePicker!.date = NSDate()
        
        self.selectedDate = self.datePicker?.date
    
        self.datePicker?.addTarget(self, action: "dateChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
       
        placeBackView.addSubview(self.datePicker!)
    }
    

    
    func btnAction(sender: UIButton) {
        self.removeFromSuperview()
        if let _delaget = delegate {
            _delaget.LJDatePickerViewFinishAction(sender, dateStr: dateFormat.stringFromDate(self.selectedDate!))
        }
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        // 更新提醒时间文本框
        let formatter = NSDateFormatter()
        // 日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.stringFromDate(datePicker.date))
        self.selectedDate = datePicker.date
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
