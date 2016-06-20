//
//  ViewController.m
//  ToDoList    - http://wiki.jikexueyuan.com/project/ios-developer-library/basis.html
//
//  Created by pifoo on 16/1/5.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  iOS 开发初体验
 */
int i = 0;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    i++;
    
        // 告诉系统要拨打的电话
    NSURL *url = [NSURL URLWithString:@"tel://10010"];
        // 拨打电话
    [[UIApplication sharedApplication] openURL:url];
    
    
        // 创建一个多维动画
    CATransition *anima = [CATransition animation];
        // 设置动画类型
    anima.type = @"cube";
        // 设置动画时间
    anima.duration = 5;
        // 添加动画
    [self.view.layer addAnimation:anima forKey:nil];
    
    NSLog(@"点击了屏幕 %d 次",i);
}

@end
