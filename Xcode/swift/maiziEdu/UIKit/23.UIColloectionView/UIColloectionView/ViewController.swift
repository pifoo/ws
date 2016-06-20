//
//  ViewController.swift
//  UIColloectionView
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 创建布局
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // 设置布局方向
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        // 设置每个元素的大小
        layout.itemSize = CGSize(width: 80, height: 80)
        // 设置元素间间距
        layout.minimumInteritemSpacing = 30
        // 设置行间距
        layout.minimumLineSpacing = 30
        
        let colloectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        colloectionView.backgroundColor = UIColor.whiteColor()
        
        colloectionView.dataSource = self
        colloectionView.delegate = self
        
        // 注册一个cell类 3.1
        colloectionView.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cellID")
        
        self.view.addSubview(colloectionView)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1   // 返回分区数
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30  // 返回有多少元素
    }
    // 操作每个item的数据 3.2
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 3.3 
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.orangeColor()
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout(用来设置layout布局相关方法), 继续自 UICollectionViewDelegate
    // 设置各元素的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let tmp = indexPath.row%3
        switch tmp {
        case 0:
            return CGSizeMake(50, 50)
        case 1:
            return CGSizeMake(100, 100)
        default:
            return CGSizeMake(50, 50)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

