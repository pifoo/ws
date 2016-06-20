//
//  ViewController.swift
//  UIScrollerView
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        
        self.view.addSubview(scrollView)
        
        let view: UIView = UIView(frame: CGRectMake(100, 100, 100, 100))
        view.backgroundColor = UIColor.orangeColor()
        // 设置 scrollView 的内容区域
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height*2)
        // 设置回弹效果
        scrollView.bounces = true
        // 设置指示条的偏移位置
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        // 设置指示条是否显示
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
        // 设置是否翻页效果
        scrollView.pagingEnabled = false
        // 设置双指缩放的最小值和最大值
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        
        
        scrollView.addSubview(view)
        
        
        
        // 设置代理 
        scrollView.delegate = self
        
    }
    // 返回进行缩放的视图
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        // 返回将要改变的view
        return scrollView.subviews.first
    }
    // scrollView 减速结束时将要触发的回调
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("减速结束")
    }
    // scrollView 拖拽结束时将要触发的回调
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("拖拽结束")
    }
    // scrollView 停止动画时的触发
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("停止动画时的触发")
    }
    // scrollView 停止缩放时触发
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("停止缩放时触发")
    }
    // scrollView 开始滑动时触发
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("开始滑动")
    }
    // scrollView 滑动到顶部时触发
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        print("滑动到顶部时触发")
    }
    // 开始形变/缩放时触发
    func scrollViewDidZoom(scrollView: UIScrollView) {
        print("开始缩放时触发")
    }
    // 是否可触发状态栏回到顶部
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return true
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

