//
//  ViewController.swift
//  UITableView
//
//  Created by pifoo on 16/4/29.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { // 2. 遵守协议
    
    // 0. 数据源数组
    var dataArray:Array<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1. 创建tableView
        // let tableView: UITableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        let tableView: UITableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        
        // 初始化数组
        dataArray = ["This tour gives you enough", "information to start writing", "code in Swift by showing", "you how to accomplish", "a variety of programming tasks.", "Don’t worry if you don’t", "understand something—everything", "introduced in this tour", "is explained in detail", "in the rest of this book."]
        
        // 刷新数据
        tableView.reloadData()
        
        // 设置tableView的回弹效果
        tableView.bounces = true
        
        // 设置为编辑状态
        tableView.editing = true
        
        // 2.1 代理
        tableView.dataSource = self
        tableView.delegate = self
        
    
        
        self.view.addSubview(tableView)
        
        
    }
    
    // 2.2 实现代理
    
    // 设置分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray?.count)!
    }
    
    // 操作cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 复用cell
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellID")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellID")
        }
        
        // 设置cell的选中风格
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell!.textLabel?.text = dataArray![indexPath.row]
        
   
        
        
        return cell!
    }
    
    // 设置行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    // 设置头视图的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    // 设置尾视图高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    // 设置头视图
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
        view.backgroundColor = UIColor.orangeColor()
        return view
        
    }
    // 设置尾视图
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
        view.backgroundColor = UIColor.greenColor()
        return view
        
    }
    
    // 点击cell时触发
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击了第:\(indexPath.section)分区的第\(indexPath.row)行")
    }
    
    // 取消选中某个cell时触发
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("取消选中..")
    }
    
    
    // 编辑(删除、插入)
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        // return UITableViewCellEditingStyle.Delete
        return UITableViewCellEditingStyle.Insert
    }
    // 逻辑操作
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            dataArray?.removeAtIndex(indexPath.row)
        } else {
            dataArray?.append("New Element..")
        }
        
        tableView.reloadData()
    }
    
    // 移动
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        /* 错误的处理方式
        let str1 = dataArray?[sourceIndexPath.row]
        let str2 = dataArray?[destinationIndexPath.row]
        // 交互位置上的数据
        dataArray?[sourceIndexPath.row] = str2!
        dataArray?[destinationIndexPath.row] = str1!
        */
        
        let str = dataArray?[sourceIndexPath.row]
        dataArray?.removeAtIndex(sourceIndexPath.row)
        dataArray?.insert(str!, atIndex: destinationIndexPath.row)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

