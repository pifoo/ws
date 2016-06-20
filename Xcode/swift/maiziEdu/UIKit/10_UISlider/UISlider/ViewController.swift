 //
//  ViewController.swift
//  UISlider
//
//  Created by pifoo on 16/4/28.
//  Copyright © 2016年 何万江. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slider: UISlider = UISlider(frame: CGRectMake(20, 100, 280, 40))
    
    let imageView: UIImageView = UIImageView(frame: CGRectMake(0, 150, 320, 320))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 设置slider的取值范围
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        // 设置滑动时是否持续触发
        // slider.continuous = false
        
        // 设置滑轴颜色
        slider.minimumTrackTintColor = UIColor.greenColor()
        slider.maximumTrackTintColor = UIColor.redColor()
        
        // 设置滑块的颜色
        slider.thumbTintColor = UIColor.orangeColor()

        
        imageView.image = UIImage(named: "Caffeine.png")

        
        
        self.view.addSubview(imageView)
        self.view.addSubview(slider)
        
        
        
        
        
        
        slider.addTarget(self, action: #selector(ViewController.touchSlider(_:)), forControlEvents: UIControlEvents.ValueChanged )
        
        
    }
    
    func touchSlider(oSlider: UISlider) {
        print(oSlider.value)
        
        let value: CGFloat = (CGFloat)(slider.value)/100
        
        imageView.bounds = CGRectMake(0, 0, 512 * value, 512 * value)
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        slider.setValue((Float)(rand()%99) + 1, animated: true)  // 设置滑块的默认位置
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

