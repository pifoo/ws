//
//  ViewController.swift
//  UIWebView
//
//  Created by pifoo on 16/4/30.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let webView: UIWebView = UIWebView(frame: CGRectMake(0, 20, 320, 460))
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.baidu.com")!))
        
        
        
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

