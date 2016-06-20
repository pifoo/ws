//
//  ViewController.swift
//  UIAlertViewController之AlertView
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 1.0 低版本方法创建
        /* 1.1
        let alertView: UIAlertView = UIAlertView(title: "alert", message: "Look me", delegate: self, cancelButtonTitle: "cancel" , otherButtonTitles: "sure")
        
        alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        
        alertView.show()
         */
        
        
        
        
        
    }
    /* 1.2
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
    }*/
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 2.0 新方法创建
        // 2.1 创建 alertView
        let alertView: UIAlertController = UIAlertController(title: "alert", message: "look me", preferredStyle: UIAlertControllerStyle.Alert)
        // 添加一个文本框
        alertView.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "login"
        }
        // 2.2 创建alertAction
        let alertActionOne: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Destructive) { (alert) -> Void in
            print("cancel")
        }
        // 2.3 将action(按钮)添加至alertView
        alertView.addAction(alertActionOne)
        
        // 2.4 show
        self.presentViewController(alertView, animated: true, completion: nil)

    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

