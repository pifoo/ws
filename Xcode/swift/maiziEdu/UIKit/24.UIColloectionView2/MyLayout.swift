//
//  MyLayout.swift
//  UIColloectionView2
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class MyLayout: UICollectionViewFlowLayout {
    
    var itemCount: Int?
    var attributeArray: Array<UICollectionViewLayoutAttributes>?
    
    override func prepareLayout() { // 准备布局时...
        super.prepareLayout()
        
        attributeArray = Array()
        
        // 2列item的宽度
        let width = (UIScreen.mainScreen().bounds.size.width - self.minimumInteritemSpacing)/2
        
        // 声明左右两列的高
        var l = 0
        var r = 0

        for i in 0 ..< itemCount!  {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let attri = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            let height = random()%140+50  // (50..<140)
            
            // 标记 item 放在了哪一列
            var tmp = 0
            var h = 0 // 用于标记y
            if l <= r {
                // 将 item 放在左列
                h = l + (Int)(self.minimumLineSpacing)
                l = l + height + (Int)(self.minimumInteritemSpacing)
                tmp = 0
                
            } else {
                h = r + (Int)(self.minimumLineSpacing)
                r = r + height + (Int)(self.minimumInteritemSpacing)
                tmp = 1
               
            }
            
            attri.frame = CGRectMake( (CGFloat)(tmp) * (width + self.minimumInteritemSpacing), (CGFloat)(h), width, (CGFloat)(height) )
            
            attributeArray?.append(attri)
        }
        
        if l <= r {
            self.itemSize = CGSizeMake(width, (CGFloat)(r * 2 / itemCount!) - self.minimumInteritemSpacing)
        }
        
        
        
    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray!
    }
}

