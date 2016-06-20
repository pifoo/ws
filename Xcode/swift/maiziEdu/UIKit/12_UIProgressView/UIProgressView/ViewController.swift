//
//  ViewController.swift
//  UIProgressView
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // let progress: UIProgressView = UIProgressView(frame: CGRectMake(20, 50, 280, 30))
    let progress: UIProgressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        progress.frame = CGRectMake(20, 50, 280, 30)
        
        // 设置默认进度
        progress.progress = 0.5
        
        progress.backgroundColor = UIColor.orangeColor() 
        
        progress.progressTintColor = UIColor.greenColor() // 走过的进度色
        
        progress.trackTintColor = UIColor.blueColor() // 未走过的进度色
        
        progress.tintColor = UIColor.redColor()
        
        self.view.addSubview(progress)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

