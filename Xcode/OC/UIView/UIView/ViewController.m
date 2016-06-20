//
//  ViewController.m
//  UIView
//
//  Created by pifoo on 15/12/31.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /**
     * 视图
     */
    UIView *view1                = [[UIView alloc]init];
    view1.tag                    = 1;      // 唯一标识
    view1.frame                  = CGRectMake(10, 30, 355, 627);     // 以屏幕(父视图)左上角为坐标点(0,0)，设置其 坐标、大小
    view1.backgroundColor        = [UIColor greenColor];
    [self.view addSubview: view1];         // 加入到父视图
    
    
    // 状态栏高为 20px
    NSLog(@"屏幕大小 - w: %f ; h: %f ",[[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height);
    
    // view1 - 大小、位置
    NSLog(@"view1 - x:%f, y:%f, w:%f, h:%f",view1.frame.origin.x,view1.frame.origin.y,
          view1.frame.size.width,view1.frame.size.height);
    
    // bounds - 边框大小,      x、y永远为0
    NSLog(@"bounds - x:%f, y:%f, w:%f, h:%f",view1.bounds.origin.x,view1.bounds.origin.y,
          view1.bounds.size.width,view1.bounds.size.height);
    
    // center - 中心点
    NSLog(@"center - x:%f, y:%f ",view1.center.x,view1.center.y);
    
    
    // (获取)父视图（唯一）
    UIView *superView            = view1.superview;
    superView.backgroundColor    = [UIColor redColor];
    
    UIView *view2                = [[UIView alloc]init];
    view2.tag                    = 2;
    view2.frame                  = CGRectMake(20, 30, 315, 200);
    view2.backgroundColor        = [UIColor blueColor];
    [view1 addSubview: view2];
    
    UIView *view3                = [[UIView alloc]init];
    view3.tag                    = 3;
    view3.frame                  = CGRectMake(70, 50, 160, 300);
    view3.backgroundColor        = [UIColor purpleColor];
    [view2 addSubview: view3];
    
    /**
     * （获取）子视图 （不唯一）
     */
    
        // 1.
    NSArray *subViewsArray       = view1.subviews;
    for (UIView *view in subViewsArray) {
    //view.backgroundColor       = [UIColor whiteColor];
        if (view.tag == 2) {
    //view.backgroundColor       = [UIColor whiteColor];
        }
    }
        // 2.
    UIView *subView              = [view1 viewWithTag:3];
    //subView.backgroundColor    = [UIColor blueColor];
    
    
    
    /**
     * 视图层级
     *  @return
     */
        // 交换两个层的视图
    [view1 exchangeSubviewAtIndex:0 withSubviewAtIndex:1];  // 不起作用 ？？
        // 插入视图到指定层
    UIView *view4         = [[UIView alloc]init];
    view4.frame           = CGRectMake(50, 150, 60, 100);
    view4.backgroundColor = [UIColor whiteColor];
        //[view3 addSubview: view4];
    [view1 insertSubview:view4 atIndex: 0];        // v4 插入到 0
    [view1 insertSubview:view2 belowSubview:view1];// v2 插入到 v3 下面
    [view1 insertSubview:view3 aboveSubview:view4];// v3 插入到 v4 下面
        // 将一个view放到到最顶层/最低层
    [view1 bringSubviewToFront:view4];             // 将 v4 放到 v1的最顶层
    [view1 sendSubviewToBack:view4];               // 将 v4 放到 v1的最低层
    
    /**
     *  自适应
     *
     *  @return <#return value description#>
     */
    UIView *backView             = [[UIView alloc]init];
    backView.tag                 = 1001;
    backView.frame               = CGRectMake([UIScreen mainScreen].bounds.size.width/2-25,[UIScreen mainScreen].bounds.size.height/2-25, 50, 50);
    backView.backgroundColor     = [UIColor orangeColor];
    // 准许子视图自适应
    backView.autoresizesSubviews = YES;
    [self.view addSubview:backView];
    
    UIView *topView              = [[UIView alloc]init];
    topView.frame                = CGRectMake(10, 10, 30, 30);
    topView.backgroundColor      = [UIColor whiteColor];
    // 设置子视图的适应方式
    topView.autoresizingMask     = UIViewAutoresizingFlexibleLeftMargin |
                               UIViewAutoresizingFlexibleRightMargin |
                               UIViewAutoresizingFlexibleTopMargin |
                               UIViewAutoresizingFlexibleBottomMargin |
                               UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight;
    [backView addSubview:topView];

    
    UIButton *btn                = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame                    = CGRectMake(10, 550, 355, 30);
    btn.backgroundColor          = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}

- (void)btnClick{
    UIView *view                 = [self.view viewWithTag:1001];
    view.frame                   = CGRectMake(view.frame.origin.x - 5, view.frame.origin.y - 5, view.frame.size.width + 10, view.frame.size.height + 10);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
