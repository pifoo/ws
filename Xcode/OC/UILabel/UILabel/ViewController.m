//
//  ViewController.m
//  UILabel
//
//  Created by pifoo on 16/1/1.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    /**
     文本标签
     */
    UILabel *label            = [[UILabel alloc]init];
    label.frame               = CGRectMake(10, 100, 395, 200);
    label.backgroundColor     = [UIColor whiteColor];
    // 文本
    label.text                = @"Swift is a new programming language for iOS, OS X, watchOS, and tvOS apps that builds on the best of C and Objective-C, without the constraints of C compatibility.";
    label.textAlignment       = NSTextAlignmentCenter;             // 文本布局
    label.alpha               = 0.9f;                              // lable透明色
    
    /**
     clearColor - 透明色
     */
    //label.textColor         = [UIColor redColor];
    label.textColor           = [UIColor colorWithRed:0.1 green:0.8 blue:0.2 alpha:1];
    
    /**
     *  字体设置
     */
    label.font                = [UIFont systemFontOfSize:30];
    label.font                = [UIFont boldSystemFontOfSize:25];
    label.font                = [UIFont italicSystemFontOfSize:25];
        // 遍历系统字体库
    for (NSString *fontName in [UIFont familyNames]) {
        NSLog(@"fontName : %@",fontName);
    }
    label.font                = [UIFont fontWithName:@"Bodoni 72" size:25];
        // 设置阴影(文本的)
        // 1.阴影的颜色
    // label.shadowColor      = [UIColor redColor];
        // 2.阴影的偏移(可以设负数)
    // label.shadowOffset     = CGSizeMake(2, 2);
    
    /**
     *  文本换行
     */
        // 1. label要足够大
        // 2. 设置换行模式
    label.lineBreakMode       = NSLineBreakByWordWrapping;
        // 3. 设置行数（0，-1 不限制行数）
    label.numberOfLines       = 0;
    
    /**
     *  根据字符串大小计算label大小
     *
     *  @param 355  限制宽
     *  @param 1000 限制高
     *
     *  @return 
     */
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(355, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height);
    
    [self.view addSubview:label];

    
    
}
/**
 *
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
