//
//  EditPersonalController.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/21.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class EditPersonalController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, LJPlacePickerViewDelegate, LJDatePickerViewDelegate {
    
    var BASETAGNUMBER: Int = 55555
    var selectedBtn: UIButton?
    
    // 地址选择器
    var placePickerView: LJPlacePickerView!
    // 时间选择器
    var datePickerView: LJDatePickerView!
    
    var selectedTextField: UITextField?

    /* 名字 */
    @IBOutlet weak var nameTextField: UITextField!
    /* 生日 */
    @IBOutlet weak var birthDayTextField: UITextField!
    
    @IBOutlet weak var otherSex: UIButton!
    @IBOutlet weak var womanSex: UIButton!
    @IBOutlet weak var manSex: UIButton!
    
    /* 职业 */
    @IBOutlet weak var workTextField: UITextField!
    /* 常居 */
    @IBOutlet weak var sleepPlaceTextField: UITextField!
    /* 家乡 */
    @IBOutlet weak var oldPlaceTextField: UITextField!
    /* 用户头像 */
    @IBOutlet weak var userHeaderImg: UIButton!
    /* 描述TextView */
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XCFColor(242, g: 242, b: 242)
        let leftBtn = UIButton.init(frame: CGRectMake(10, 10, 20, 20))
        leftBtn.setImage(UIImage(imageLiteral: "back"), forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action:"leftBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.title = "编辑个人资料"
        self.layotUIs()
    }
    func leftBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - 上传头像
    @IBAction func upDateUserImgAction(sender: AnyObject) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        if #available(iOS 8.0, *) {
            let actionS: UIAlertController = UIAlertController(title: "提示", message: "请选择拍照或者相册选取照片", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let action1: UIAlertAction = UIAlertAction(title: "从手机相册选择", style: UIAlertActionStyle.Default) { (action) -> Void in
                // 直接推到图片选择器，默认是相册
                self.navigationController?.presentViewController(picker, animated: true, completion: nil)
            }
            
            let action2: UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                    // 将图片选择器的样式设置成调用相机
                    picker.sourceType = UIImagePickerControllerSourceType.Camera
                    // 退出图片选择器
                    self.navigationController?.presentViewController(picker, animated: true, completion: nil)
                } else {
                    print("模拟器不支持拍照")
                }
            }
            
            let action: UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
            }
            
            actionS.addAction(action1)
            actionS.addAction(action2)
            actionS.addAction(action)
            
            self.navigationController?.presentViewController(actionS, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - imagePickerControllerDelagete
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let imageP: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.userHeaderImg .setImage(imageP, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - 男、女、其他 性别按钮点击事件
    @IBAction func sexButtonsAction(sender: UIButton) {
        self.view.endEditing(true)
        if selectedBtn != sender {
            selectedBtn?.backgroundColor = UIColor.whiteColor()
            selectedBtn?.setTitleColor(XCFColor(102, g: 102, b: 102), forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.brownColor()
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        selectedBtn = sender
    }
    
    // MARK: - textFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        print("输入框开始编辑")
        self.selectedTextField = textField
        
        if textField.tag/BASETAGNUMBER == 2 {
            print("日期选择器")
            let inputView: UIView = UIView.init(frame: CGRectZero)
            textField.inputView = inputView
            self.layoutDatePickerView()
        } else if textField.tag/BASETAGNUMBER == 4 || textField.tag/BASETAGNUMBER == 5 {
            let inputView: UIView = UIView.init(frame: CGRectZero)
            textField.inputView = inputView
            // 显示UIPickerView
            self.layoutPlacePickerView()
        }
    }

    
    func dismissPickerViewAction(button: UIButton!,  provinceStr: String?, cityStr: String?, townStr: String?) {
        self.view.endEditing(false)
        
        let titleStr:NSString = (button.titleLabel?.text)! as NSString
        if titleStr.isEqualToString("完成") {
        var newStr = String()
        newStr += provinceStr!
        newStr += ","
        newStr += cityStr!
        
        if ((townStr?.isEmpty) != nil) {
            newStr += ","
            newStr += townStr!
        }
        
        self.selectedTextField?.text = newStr
        }
    }
    
    func LJDatePickerViewFinishAction(sender: UIButton, dateStr: String) {
        self.view.endEditing(false)
        
        let titleStr:NSString = (sender.titleLabel?.text)! as NSString
        if titleStr.isEqualToString("完成") {
            self.birthDayTextField.text = dateStr
        }
    }
    
    func layoutPlacePickerView() {
        self.placePickerView = LJPlacePickerView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT))
        self.placePickerView.delegate = self
        self.view.window!.addSubview(self.placePickerView)
    }
    
    func layoutDatePickerView() {
        self.datePickerView = LJDatePickerView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT))
        self.datePickerView.delegate = self
        self.view.window!.addSubview(self.datePickerView)
    }
       
    func layotUIs() {
        self.nameTextField.tag = BASETAGNUMBER
        self.nameTextField.delegate = self
        
        self.birthDayTextField.tag = 2*BASETAGNUMBER
        self.birthDayTextField.delegate = self
        
        self.workTextField.tag = 3*BASETAGNUMBER
        self.workTextField.delegate = self
        
        self.oldPlaceTextField.tag = 4*BASETAGNUMBER
        self.oldPlaceTextField.delegate = self
        
        self.sleepPlaceTextField.tag = 5*BASETAGNUMBER
        self.sleepPlaceTextField.delegate = self
        
        self.nameTextField.returnKeyType = UIReturnKeyType.Google
        
        self.manSex.layer.masksToBounds = true
        self.manSex.layer.cornerRadius = 8.5
        self.womanSex.layer.masksToBounds = true
        self.womanSex.layer.cornerRadius = 8.5
        self.otherSex.layer.masksToBounds = true
        self.otherSex.layer.cornerRadius = 8.5
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
