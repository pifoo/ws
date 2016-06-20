//
//  ViewController.swift
//  UINavigationController
//
//  Created by pifoo on 16/5/1.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.magentaColor()
        self.title = "title"
        
        let label: UILabel = UILabel(frame: CGRectMake(50, 100, 220, 30))
        label.backgroundColor = UIColor.orangeColor()
        label.text = "Hello World."
        label.textAlignment = NSTextAlignment.Center
        
        let button: UIButton = UIButton(frame: CGRectMake(100, 200, 100, 30))
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle("切换", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        
        self.view.addSubview(label)
        self.view.addSubview(button)
        
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.cyanColor()
        
        let barButtonItem: UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.back))
        
        let barR1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: #selector(ViewController.actionR1))
        let barR2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: #selector(ViewController.actionR2))
        
        
        button.addTarget(self, action: #selector(ViewController.btnChange(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // self.navigationItem.backBarButtonItem = barButtonItem
        self.navigationItem.leftBarButtonItem = barButtonItem
        self.navigationItem.rightBarButtonItems = [barR1, barR2]
        
        self.navigationController?.toolbarHidden = false
        
        self.toolbarItems = [barR1, barR2]
        
    }
    
    
    func btnChange(oBtn: UIButton) {
        let viewController: ViewController = ViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    
    func back() {
        print("back")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func actionR1() {
        print("actionR1")
    }
    
    func actionR2() {
        print("actionR2")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

