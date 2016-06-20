//
//  Student.m
//  les
//
//  Created by pifoo on 16/1/12.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import "Student.h"

@implementation Student

// 重写-init
- (instancetype)init
{
    if (self = [super init]) {
        _no = 1;
    }
    return self;
}

/**
 *  类方法
 */
// 1. 当程序启动的时候，就会加载一次项目中所有的类。类加载完毕后就会调用 +load() ;
+ (void)load    // 类加载完毕调用一次
{
    NSLog(@"Person --- +load() ");
}
// 2. 当第一次使用这个类的时候，就会调用一次 +initialize() ;
+ (void)initialize // 类初始化时调用一次
{
    NSLog(@"Person --- +initialize() ");
}



@end
