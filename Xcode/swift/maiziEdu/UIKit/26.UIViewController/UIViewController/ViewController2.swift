//
//  ViewController2.swift
//  UIViewController
//
//  Created by pifoo on 16/5/1.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var tmp: Int = 0
    
    override func loadView() {
        super.loadView()
        tmp++
        print(tmp, "loadView()")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tmp++
        print(tmp, "viewDidLoad()")
    }
    
    // 视图将要展示时的调用
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tmp++
        print(tmp, "viewWillAppear()")
    }
    
    // 将要布局子视图
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tmp++
        print(tmp, "viewWillLayoutSubviews()")
    }
    
    // 子视图布局完毕
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tmp++
        print(tmp, "viewDidLayoutSubviews()")
    }
    
    // 视图已经展现
    override func viewDidAppear(animated: Bool) {
        super.viewDidLayoutSubviews()
        tmp++
        print(tmp, "viewDidLayoutSubviews()")
    }
    
    // 视图将要消失
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tmp++
        print(tmp, "viewWillDisappear()")
    }
    
    // 视图已经消失
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        tmp++
        print(tmp, "viewDidDisappear()")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 回到上一个 ViewController
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
