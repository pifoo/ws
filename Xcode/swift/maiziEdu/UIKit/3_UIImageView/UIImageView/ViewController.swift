//
//  ViewController.swift
//  UIImageView
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 1. 
        let imageView = UIImageView(frame: CGRectMake(20, 100, 150, 150))
        
        imageView.backgroundColor = UIColor.greenColor()
        imageView.image = UIImage(named: "jy.pngs/1.png")
        
        //imageView.highlightedImage = UIImage(named: "jy.pngs/2.png")
        //imageView.highlighted = true

        
        
        self.view.addSubview(imageView)
        
        
        
        // 动画数组
        var array: Array<UIImage!> = Array()
        for i in 1...16 {
            let image: UIImage? = UIImage(named: "jy.pngs/\(i).png")
            array.append(image)
        }
        
        // 帧动画
        imageView.animationImages = array as? [UIImage]
        imageView.animationRepeatCount = 0  // 播放次数
        
        imageView.animationDuration = 1.5   // 播放一轮的时间
        imageView.startAnimating()          // 开始动画
        
        
        
        // 2.
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

