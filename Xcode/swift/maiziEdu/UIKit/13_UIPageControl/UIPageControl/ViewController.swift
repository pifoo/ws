//
//  ViewController.swift
//  UIPageControl
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 创新一个分页控制器
    let page: UIPageControl = UIPageControl(frame: CGRectMake(100, 100, 100, 30))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orangeColor()
        page.currentPageIndicatorTintColor = UIColor.whiteColor() // 当前页颜色
        page.pageIndicatorTintColor = UIColor.greenColor()       // 分页器颜色
        
        
        page.numberOfPages = 6
        page.currentPage = 2
        
        page.hidesForSinglePage = true  // 为 1 页时隐藏分页控制器
        
        
        
        self.view.addSubview(page)
        
        page.addTarget(self, action: #selector(ViewController.pageChange(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    
    func pageChange(oPage: UIPageControl) {
        print(oPage.currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

