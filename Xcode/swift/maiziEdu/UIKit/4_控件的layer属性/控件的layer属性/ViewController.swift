//
//  ViewController.swift
//  控件的layer属性
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let imageView =  UIImageView(frame: CGRectMake(100, 100, 100, 100))
        
        imageView.backgroundColor = UIColor.greenColor()
        
        // 设置圆角
        // imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        
        // 设置边框
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.blueColor().CGColor
        
        // 设置阴影
        imageView.layer.shadowColor = UIColor.orangeColor().CGColor
        imageView.layer.shadowOffset = CGSizeMake(5, 5)
        imageView.layer.shadowOpacity = 1
        
        
        
        
        
        
        self.view.addSubview(imageView)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

