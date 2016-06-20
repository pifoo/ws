//
//  ViewController.swift
//  UITextField
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate { // 2.0 遵守代理协议
    
    let textField: UITextField = UITextField(frame: CGRectMake(20, 100, 280, 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        // textField.backgroundColor = UIColor.greenColor()
        textField.borderStyle = UITextBorderStyle.Bezel
        textField.placeholder = "请输入内容"
        textField.textColor = UIColor.blueColor()
        textField.font = UIFont.boldSystemFontOfSize(20)
        //textField.font = UIFont.italicSystemFontOfSize(15)
        textField.textAlignment = NSTextAlignment.Center
        
        // 是否每次进入编辑状态即清空文本框的内容
        textField.clearsOnBeginEditing = true
        // 是否字体大小自适应
        textField.adjustsFontSizeToFitWidth = true
        // 设置输入框为无效
        // textField.enabled = false
        
        // 设置清除按钮的显示模式
        textField.clearButtonMode = UITextFieldViewMode.Always
        
        
        // 设置textField的左、右视图
        let viewLeft: UIView = UIView(frame: CGRectMake(0, 0, 40, 40))
        let viewRight: UIView = UIView(frame: CGRectMake(0, 0, 40, 40))
        viewLeft.backgroundColor = UIColor.greenColor()
        viewRight.backgroundColor = UIColor.blueColor()
        textField.leftView = viewLeft
        textField.rightView = viewRight
        // 设置左右视图的显示模式
        textField.leftViewMode = UITextFieldViewMode.Always
        //textField.rightViewMode = UITextFieldViewMode.Always
        
        // 设置弹出的交互键盘
        let board: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
        board.backgroundColor = UIColor.orangeColor()
        // textField.inputView = board
        
        // 设置附键盘视图
        textField.inputAccessoryView = board
        
        
        self.view.addSubview(textField)
        
        
        // 2.1 设置代理
        textField.delegate = self
        
        
        textField.addTarget(self, action: #selector(ViewController.textFieldClick(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
    }
    
    // 2.2 实现代理(回调)
    
    // 当输入改变时调用
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("当输入改变时调用..\(string)")
        
        return true  // true: 才能输入到文本框
    }
    
    // textField 已进入编辑状态时的回调
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textField 已进入编辑状态时的回调")
    }
    
    // textField 结束编辑状态时的回调
    func textFieldDidEndEditing(textField: UITextField) {
        print("textField 结束编辑状态时的回调")
    }
    
    // 将要进入编辑状态
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("将要进入编辑状态....")
        
        return true // false: 无法进入编辑
    }
    
    // 将要结束编辑状态
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("将要结束编辑状态....")
        
        return true  // false: 无法结束编辑
    }
    
    // 触发清除按钮时的回调
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("文本内容可以被删除")
        return true // false: 不可清除
    }
    
    // 触发return键时的回调
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("触发return键时的回调")
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    
    
    
    
    func textFieldClick(oTex: UITextField) {
        if oTex.editing == true {
            print("当前为编辑状态...") 
        }
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textField.resignFirstResponder() // 注销第一响应
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

