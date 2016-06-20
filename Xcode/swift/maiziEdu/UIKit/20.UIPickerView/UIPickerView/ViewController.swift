//
//  ViewController.swift
//  UIPickerView
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate { // 1
    
    var dataArray: Array<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pickerView: UIPickerView = UIPickerView(frame: CGRectMake(0, 100, 320, 200))
        
        // 2 设置数据源与代理
        pickerView.dataSource = self
        pickerView.delegate = self
        
        dataArray = ["one", "two", "three", "four", "five"]
        
        self.view.addSubview(pickerView)
        
    }
    // 3 实现代理 
    
    /*
        和 UITableView 一样，以下三个代理方法必须先实现
     */
    // 返回分区数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    // 设置每个分区的行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    // 设置每一行的内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray![row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("选中了分区\(component)中的第\(row)行 ")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

