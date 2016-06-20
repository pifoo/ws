//
//  ViewController.swift
//  UILabel
//
//  Created by pifoo on 16/4/26.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
            UILabel
         */
        
        
        // 1. 实例化
        let label: UILabel = UILabel(frame: CGRectMake(20, 100, 280, 100))
        
        
        // 2. 修改属性
        label.text = "Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen."
        
        label.font = UIFont.boldSystemFontOfSize(19)
        
        label.textColor = UIColor.whiteColor()
        // label.textColor= UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
       
        label.backgroundColor = UIColor.blueColor()
        
        label.textAlignment = NSTextAlignment.Center    // .Center
        
        label.shadowColor = UIColor.orangeColor()
        // label.shadowOffset = CGSizeMake(2, 2)
        
        label.numberOfLines = 0 // 0：无限行
        
        label.alpha = 0.5
       
        
        // 3. 添加视图
        self.view.addSubview(label)
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

