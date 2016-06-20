//
//  ViewController.swift
//  UIAlertViewController之ActionSheet
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1.0 使用低版本方法创建
        /*
        let sheet: UIActionSheet = UIActionSheet(title: "action sheet", delegate: self, cancelButtonTitle: "cance", destructiveButtonTitle: "delete")
 
        sheet.showInView(self.view)
        */
        
        
        
    }
    
    
    // 2.0 使用最新版本方法创建
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let actionSheet: UIAlertController = UIAlertController(title: "action sheet", message: "look me", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let actionDelete: UIAlertAction = UIAlertAction(title: "delete", style: UIAlertActionStyle.Default) { (oAction) in
            print("delete")
        }
        let actionCancel: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Destructive) { (oCancel) in
            print("cancel")
        }
        actionSheet.addAction(actionDelete)
        actionSheet.addAction(actionCancel)
        
        self.presentViewController(actionSheet, animated: true) { 
            print("actionSheet。。")
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

