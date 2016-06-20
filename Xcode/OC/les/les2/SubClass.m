//
//  SubClass.m
//  les
//
//  Created by pifoo on 15/12/30.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import "SubClass.h"

@implementation SubClass
- (void)show
{
    /*
     1、父类中的私有变量不能被继承<br>
     2、如果继承了父类中使用了私有变量的方法，则继承后的私有变量可访问；但不能在子类中直接使用此私有变量；
     3、如果父类没有声明方法，只有实现，则子类不能继承父类的方法；
     4、如果一个方法只写了实现，相当于是本类中的私有方法
     */
    //_classStr = @"2341";//子类不能访问父类中的私有变量
    _classInt = 1001;
    NSLog(@"show - %d ",_classInt);
        //NSLog(@"classStr - %@ ", _classStr);//继承来的方法中的私有变量不能直接访问，但继承来的方法可访问
    [self reportf]; //、、调用本类中的方法

}

- (void)print
{
    [super print];
        //[self print];
    NSLog(@"SubClass 黑白打印机");
}

@end
