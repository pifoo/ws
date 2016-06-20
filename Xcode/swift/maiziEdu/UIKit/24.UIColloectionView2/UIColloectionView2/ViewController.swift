//
//  ViewController.swift
//  UIColloectionView2
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myLayout: MyLayout = MyLayout()
        myLayout.itemCount = 100
        
        let colloectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: myLayout)
        colloectionView.delegate = self
        colloectionView.dataSource = self
        
        colloectionView.registerClass(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cellID")
        
        self.view.addSubview(colloectionView)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor(red: (CGFloat)(rand()%255)/255.0, green: (CGFloat)(rand()%255)/255.0, blue: (CGFloat)(rand()%255)/255.0, alpha: 1)
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

