//
//  ViewController.swift
//  UISteper
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let steper: UIStepper = UIStepper(frame: CGRectMake(100,100,280,100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        steper.tintColor = UIColor.greenColor()
        
        
        steper.minimumValue = 0
        steper.maximumValue = 10
        steper.stepValue = 2        // 步长
        steper.continuous = false   // 是否连续触发响应函数
        steper.autorepeat = false   // 值是否持续改变
        steper.wraps = true         // 是否循环触发
        
        
        self.view.addSubview(steper)
        
        
        steper.addTarget(self, action: #selector(ViewController.stepperClick(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    
    func stepperClick(oSteper: UIStepper) {
        print(oSteper.value)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

