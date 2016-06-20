//
//  ViewController.swift
//  UISerchBar
//
//  Created by pifoo on 16/4/27.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate { // 1. 继承 UISerchBarDlegate
    
    let searchBar: UISearchBar = UISearchBar(frame: CGRectMake(20, 100, 280, 80))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.placeholder = "请输入关键字 占位符"
        searchBar.text = "key word"
        
        searchBar.tintColor = UIColor.greenColor()   // 设置渲染颜色
        searchBar.barTintColor = UIColor.blueColor() // 搜索栏边框色
        
        searchBar.barStyle = UIBarStyle.Default
        searchBar.showsBookmarkButton = true
        // searchBar.showsSearchResultsButton = true
        
        searchBar.prompt = " "
        // 设置附件视图
        searchBar.scopeButtonTitles = ["1", "2", "3", "4"]
        searchBar.showsScopeBar = true
        
        // 2. 设置代理
        searchBar.delegate = self
    
        self.view.addSubview(searchBar)
        
    }
    
    // 0. 注销第一响应,空白处可关闭键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
        
    }
    
    // 3. 代理回调函数
    
    // 3.1 触发附件视图 代理方法的回调
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
    
    // 3.2 输入框文本变化时的回调
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    // 3.3 触发Bookmark图标的回调
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        print("点击了 Bookmark")
    }
    
    // 3.4 点击搜索结果按钮的回调
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
    
    }
    
    // 3.5 将要进入编辑状态时的回调
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        return true // false 无法编辑
    }
    
    // 3.6 结束编辑时的回调
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        return true // 无法结束编辑
    }
    
    // 3.7 监测用户输入
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        print(text)
        
        return true
    }
    
    // 3.8 触发取消(退格)按钮时的回调
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("点击了取消")
    }
    
    // 3.9 点击搜索按钮时的回调
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("点击了搜索")
    }
    
    
    // 3.10 进入编辑状态时的回调
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("正在编辑... ")
    }
    
    // 3.11 
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("将要结束编辑...")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}






















