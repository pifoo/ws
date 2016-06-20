//
//  ViewController.swift
//  UIActivityIndicatorVIew
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //let activity: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(20,100,280,100))
    let activity: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orangeColor()
        activity.color = UIColor.greenColor()
        
        activity.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.height/2)
        
        self.view.addSubview(activity)
        activity.startAnimating()
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        activity.stopAnimating()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

