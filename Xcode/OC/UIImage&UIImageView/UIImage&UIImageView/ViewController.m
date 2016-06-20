//
//  ViewController.m
//  UIImage&UIImageView
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
    
#if 0
        // 得到工程路径
    NSString *path               = [[NSBundle mainBundle]resourcePath];
    NSString *imgPath            = [NSString stringWithFormat:@"%@/stocks.png",path];//图片路径
    NSLog(@"imgPath : %@ ",imgPath);
    
    /**
     *  图片加载的 3 种方式
     */
        // 1. 此种方式每次使用都要重新加载
    UIImage *image               = [[UIImage alloc]initWithContentsOfFile:imgPath];
        // 2. 加载二进制image
    //image                      = [UIImage alloc]initWithData:<#(nonnull NSData *)#>;
        // 3. 加载到内存中
    image                        = [UIImage imageNamed:@"stocks.png"];
    NSLog(@"image: w - %f , h - %f ",image.size.width,image.size.height);
    
    /**
     *  载体（图片必须使用载体呈现）
     */
    UIImageView *imageView       = [[UIImageView alloc]initWithImage:image];
    imageView.backgroundColor    = [UIColor colorWithRed:0.69 green:0.82 blue:0.46 alpha:1];
        // 图片显示大小由 载体 控制
    imageView.frame              = CGRectMake(10, 100, image.size.width, image.size.height);
    [self.view addSubview:imageView];
    
    /**
     *  内容模式
     *  UIViewContentModeCenter - 居中，不被拉伸
     *  UIViewContentModeScaleToFill - 拉伸，充满容器
     */
    imageView.contentMode        = UIViewContentModeCenter;
#endif
    
    
    /**
     *  UIImageView 动画 - 播放序列图
     *
     *
     */
    NSMutableArray *imageArray   = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 16; i ++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"./jy.pngs/%d.png",i]];
        [imageArray addObject:img];
    }
    UIImageView *imgView         = [[UIImageView alloc]init];
    imgView.frame                = CGRectMake(10, 50, 300, 300);
    [self.view addSubview:imgView];
        // 设置动画数组
    imgView.animationImages      = imageArray;
        // 设置播放周期时间
    imgView.animationDuration    = 2;
        // 执行次数 0 - 无限次
    imgView.animationRepeatCount = 0;
        // 开始动画
    [imgView startAnimating];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
