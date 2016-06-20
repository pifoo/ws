//
//  ViewController.swift
//  Code
//
//  Created by pifoo on 16/4/22.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var textAddend: UITextField!
    @IBOutlet weak var textSummand: UITextField!
    @IBOutlet weak var calculationResult: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print("viewDidLoad....")
        
        
        
        /******************** 以下代码纯手写  ********************/
        
        
        
        /*
            实例化一个Label
            1. 创建对象
            2. 修改属性
            3. 加入视图
         */
        
        
        // 1. 创建对象
        let label = UILabel()
        
        // 2. 修改属性
        label.frame = CGRect(x: 20, y: 30, width: 280, height: 40)
        label.layer.borderWidth = 0.2
        //label.layer.borderColor =
        label.backgroundColor = UIColor.greenColor()
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center  // NSTextAlignment.Center
        label.text = "实用计算器"
        
        // 3. 加入视图
        self.view.addSubview(label)
        
        
        /*
         实例化一个Button
         1. 创建对象
         2. 修改属性
         3. 加入视图
         */
        
        let button = UIButton.init(type: .System) as UIButton
        
        button.frame = CGRect(x: 120, y: 80, width: 80, height: 40)
        button.setTitle("Button", forState: .Normal)
        
        self.view.addSubview(button)

        
        // 4. 链接事件 (理解参数3，1，2)
        button.addTarget(self, action: #selector(ViewController.btnTab), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
    }
    // 4.1 定义事件函数
    func btnTab() {
        print("当 button 按钮产生 TouchUpInside 事件时，则 当前 对象调用 btnTab 函数.. ")
    
        // alert消息框
        let alertMessage = UIAlertController(title: "实用计算器", message: "超级实用计算器", preferredStyle: UIAlertControllerStyle.ActionSheet) // .Alert
        let okActon = UIAlertAction(title: "好", style: UIAlertActionStyle.Default) { (_) -> Void in
            print("点击了 ‘好’ 按钮")
        }
        
        alertMessage.addAction(okActon)
        
        // self.presentViewController(alertMessage, animated: true, completion: nil)
        self.presentViewController(alertMessage, animated: true) { 
            print("显示了一个alert消息")
        }
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /********************  以下代码借助编辑器拖拽完成  ********************/
    
    
    
    var rpResult = [" , 聪明好学",
                    " , 四肢发达",
                    " , 说一不二",
                    " , 多才多艺",
                    " , 头脑简单",
                    " , 朝三慕四"]

    @IBAction func tab(sender: AnyObject) {
        print("超级 rp 计算器 ...")
        
        label.text = "超级人品计算器"
        
        resultLabel.text = textField.text! + rpResult[Int(arc4random_uniform(6))] // 生成随机数
    }
    
    
    
    /*
        计算器
     */
    
    @IBAction func add(sender: AnyObject) {
        print(" + ")
        
        // string -> double
        let value1 = (textAddend.text! as NSString).doubleValue
        let value2 = (textSummand.text! as NSString).doubleValue
        
        // 形态转换  string -> int
        // let sum = Int(textAddend.text!)! + Int(textSummand.text!)!
        // (textAddend.text! as NSString).integerValue
        
        let result1 = value1 + value2
        
        calculationResult.text = "\(textAddend.text!) + \(textSummand.text!) = " + String(format: "%f",result1) // double -> string
        
    }

    @IBAction func subtract(sender: AnyObject) {
        print(" - ")
        
        let value1 = (textAddend.text! as NSString).doubleValue
        let value2 = (textSummand.text! as NSString).doubleValue
        
        let result2 = value1 - value2
        
        calculationResult.text = "\(textAddend.text!) - \(textSummand.text!) = " + String(format: "%f",result2)
        
        // String(format: "%d",i)    // int -> string

        
    }
 
    @IBAction func multiply(sender: AnyObject) {
        print(" x ")
        
        let value1 = (textAddend.text! as NSString).doubleValue
        let value2 = (textSummand.text! as NSString).doubleValue
        
        let result3 = value1 * value2
        
        calculationResult.text = "\(textAddend.text!) x \(textSummand.text!) = " + String(format: "%f",result3)
        
    }
    
    @IBAction func divide(sender: AnyObject) {
        print(" / ")
        
        let value1 = (textAddend.text! as NSString).doubleValue
        let value2 = (textSummand.text! as NSString).doubleValue
        
        if value2 != 0 {
            let result4 = value1 / value2
            calculationResult.text = "\(textAddend.text!) ÷ \(textSummand.text!) = " + String(format: "%f",result4)
        } else {
            calculationResult.text =  "sorry,除数不能为 0"
        }
        
        
    }
    
    

    @IBAction func CloseKeyborad(sender: AnyObject) {
        textField.resignFirstResponder()
        
    }
    
    
    


    
    
    
}

















