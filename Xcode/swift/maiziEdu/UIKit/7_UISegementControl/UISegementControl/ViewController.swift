//
//  ViewController.swift
//  UISegementControl
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let seg: UISegmentedControl = UISegmentedControl(frame: CGRectMake(20, 100, 280, 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        
        //seg.backgroundColor = UIColor.greenColor()
        
        
        // 设置分段控制器的按钮
        seg.insertSegmentWithTitle("按钮 1 : item 1", atIndex: 0, animated: true)
        seg.insertSegmentWithTitle("按钮 2 ", atIndex: 1, animated: true)
        seg.insertSegmentWithTitle("按钮 3 ", atIndex: 2, animated: true)
        
        self.view.addSubview(seg)
        
        
        seg.addTarget(self, action: #selector(ViewController.segClick), forControlEvents: UIControlEvents.ValueChanged)
        
        // 设置分段控制是否保持选中状态
        seg.momentary = false
        
        // 设置分段控制器根据内容自适应
        seg.apportionsSegmentWidthsByContent = true
        
        // 设置某个item的宽度
        seg.setWidth(30, forSegmentAtIndex: 2)
        
        // 设置内容区域的偏移量
        seg.setContentOffset(CGSizeMake(10, 10), forSegmentAtIndex: 0)
        
        // 设置默认选中项
        seg.selectedSegmentIndex = 1
        
        // 设置颜色
        seg.tintColor = UIColor.blueColor()
        
        
        
    }
    
    func segClick(oSeg: UISegmentedControl) {
        print("segment \(oSeg.selectedSegmentIndex) 按钮被点击...")
        print("按钮title: " , oSeg.titleForSegmentAtIndex(oSeg.selectedSegmentIndex)!)
    }
    
    // 动态插入按钮
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if seg.numberOfSegments <= 3 {
            seg.insertSegmentWithTitle("按钮 4 ", atIndex: 3, animated: true)
            //print(seg.index)
        }

        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

