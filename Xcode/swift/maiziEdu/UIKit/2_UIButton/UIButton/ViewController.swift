//
//  ViewController.swift
//  UIButton
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
            UIButton
         */
        
        // 1.1 实例化对象
        
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        
        // 1.2 修改属性
        button.frame = CGRectMake(100, 100, 120, 100)
        button.setTitle("button换肤", forState: UIControlState.Normal) // 标题，交互状态
        button.backgroundColor = UIColor.blueColor()
        // 设置button内容区域的偏移量
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        // 设置背景图片 及 内容图片
        button.setBackgroundImage(UIImage(named: ("Icon120.png")), forState: UIControlState.Normal)
        //button.setImage(UIImage(named: ("Icon120.png")), forState: UIControlState.Normal)
        
        // 添加按钮的点击视觉效果
        button.showsTouchWhenHighlighted = true
        
        // 设置高亮状态下的按钮标题
        button.setTitle("高亮按钮", forState: UIControlState.Highlighted)

        
        // 1.3 添加视图
        self.view.addSubview(button)
        
        
        
        
        // 2. 添加事件
        
        // 参数理解： 对象，事件名，事件类型
        
        // 不建议使用
        // button.addTarget(self, action: Selector("btnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        
        // 2.1
        button.addTarget(self, action: #selector(ViewController.btnClick), forControlEvents: UIControlEvents.TouchUpInside)


        
        
        
    }
    
    // 2.2 定义事件
    func btnClick(btn: UIButton) {
        print("按钮被点击了...")
        // button随机换色：random 生成随机数据并对其255取余, /255
        btn.backgroundColor = UIColor(red: CGFloat(random()%255)/255, green: CGFloat(random()%255)/255 , blue: CGFloat(random()%255)/255, alpha: 1)
        
        // 取得某种交互状态下按钮名称
        print((btn.titleForState(UIControlState.Normal))!)
    }

    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

