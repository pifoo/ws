//
//  ViewController.swift
//  UIDatePicker
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let datePicker: UIDatePicker = UIDatePicker(frame: CGRectMake(20, 100, 280, 200))
        
        // 设置显示模式
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        
        self.view.addSubview(datePicker)
        
        // 添加监听
        datePicker.addTarget(self, action: #selector(ViewController.changeDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func changeDate(oDate: UIDatePicker) {
        let date = oDate.date
        print(date)
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

