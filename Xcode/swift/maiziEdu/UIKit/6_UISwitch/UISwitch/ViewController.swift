//
//  ViewController.swift
//  UISwitch
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let uiSwitch: UISwitch = UISwitch(frame: CGRectMake(100, 50, 0, 0))
        
        // 自定义UI
        // uiSwitch.backgroundColor = UIColor.redColor()
        uiSwitch.tintColor = UIColor.orangeColor()      // 开关关闭的颜色
        uiSwitch.onTintColor = UIColor.greenColor()     // 开关开启的颜色
        uiSwitch.thumbTintColor = UIColor.orangeColor() // 开关滑块的颜色
        
        
        
        
        self.view.addSubview(uiSwitch)
        
        
        
        uiSwitch.addTarget(self, action: #selector(ViewController.switchClick), forControlEvents: UIControlEvents.ValueChanged)
        
        
        
    }
    
    func switchClick(swi: UISwitch) {
        if swi.on {
            self.view.backgroundColor = UIColor.cyanColor()
            print("开关已打开")
        } else {
            self.view.backgroundColor = UIColor.brownColor()
            print("开关已关闭")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

