//
//  ViewController.swift
//  UISegementControlApplication
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let seg: UISegmentedControl = UISegmentedControl(items: ["blue", "green"])
    
    let viewBlue: UIView = UIView(frame: CGRectMake(0, 0, 320, 568))
    let viewGreen: UIView = UIView(frame: CGRectMake(0, 0, 320, 568))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewBlue.backgroundColor = UIColor.blueColor()
        viewGreen.backgroundColor = UIColor.greenColor()
        
        self.navigationItem.titleView = seg
        self.view.addSubview(viewBlue)
        self.view.addSubview(viewGreen)
        
        self.view.bringSubviewToFront(viewBlue) // 将 viewBlue 置于最上面
        seg.selectedSegmentIndex = 0            // 默认选中第一个 item
        
        seg.addTarget(self, action: #selector(ViewController.segChange), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func segChange(oSeg: UISegmentedControl) {
        if oSeg.selectedSegmentIndex == 0 {
            self.view.bringSubviewToFront(viewBlue)
        } else {
            self.view.bringSubviewToFront(viewGreen)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

