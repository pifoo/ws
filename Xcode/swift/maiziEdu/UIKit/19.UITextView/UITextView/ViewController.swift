//
//  ViewController.swift
//  UITextView
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    let textView: UITextView = UITextView(frame: CGRectMake(20, 50, 280, 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        textView.backgroundColor = UIColor.orangeColor()
        textView.font = UIFont.boldSystemFontOfSize(25)
        textView.textColor = UIColor.whiteColor()
        textView.textAlignment = NSTextAlignment.Center
        // 识别电话号码
        textView.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber
        
        
        self.view.addSubview(textView)
        
        
        // 设置代理
        textView.delegate = self
        
    }
    
    // 实现代理
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        print("输入字符时调用")
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        print("开始编辑时调用 ")
    }
    
    func textViewDidChange(textView: UITextView) {
        print("输入改变时调用")
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        print("改变选中文字时调用")
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        print("结束编辑时调用")
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("将要开始编辑时调用")
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("将要结束编辑时调用")
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textView.resignFirstResponder() // 注销第一响应
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

