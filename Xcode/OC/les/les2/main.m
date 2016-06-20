//
//  main.m
//  les2  Objective-C面向对象初体验 ： http://www.imooc.com/learn/373
//
//  Created by pifoo on 15/12/28.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People.h"
#import "OODemo.h"
#import "SubClass.h"
#import "SubClass1.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Objective-C 面向对象初体验 : ");
        
        
        // 实例化对象
        /*
         [类名 方法名]
         [对象名 方法名]
         alloc - 为对象分配内存空间
         init - 进行初始化操作
         */
        // []方法调用
        People *p1 = [[People alloc] init];             // init - 初始化方法
        People *p2 = [People new];                      // OC不建议使用上此种方式实例化对象
        NSLog(@"p1 - %p ",p1);
        NSLog(@"p2 - %p ",p2);
        
        //[p1 setName:@"lishi"];
        //NSLog(@"peopleName - %@",[p1 getName]);
        
        //p1.peopleName = @"hewj";
        NSLog(@"p1.peopleName - %@",p1.peopleName);
        
        
        // 方法调用
        [p1 report];
        [People report1];
        
        int a1 = [p1 showWithA:10];
        NSLog(@"[p1 showWithA:10] %d ",a1);
        int a2 = [p1 showWithA:10 andB: 10];
        NSLog(@"[p1 showWithA:10 andB: 10] %d ",a2);
        int a3 = [p1 showWithA:10 : 10];
        NSLog(@"[p1 showWithA:10 : 10] %d ",a3);
        
        
        
        NSLog(@"重写init()初始化 -----------------");
        int a4 = [p1 report];
        NSLog(@"a4 = %d ",a4);
        
        NSLog(@"自定义初始化 initWithPeopleName()方法 -----------------");
        People *p3 = [[People alloc] initWithPeopleName:@"MyName:hewj" andPeopleAge:30];
        People *p4 = [[People alloc] initWithPeopleName:@"MyName:pifoo" andPeopleAge:31];
        int a5 = [p3 report];
        int a6 = [p4 report];
        //NSLog(@"a5 = %d ",a5);
        //NSLog(@"a6 = %d ",a6);

        
        
        NSLog(@"--------- OODemo， OO三特性 ： 封装、继承、多态 --------");
        
        NSLog(@"--------- 封装 --------");
        OODemo *o = [[OODemo alloc] init];
        o.className = @"OODemo.h";
        o->_classInt = 20;   // public 成员变量在类外 无法使用“.”语法访问，要使用指向“->”
        // o->_classStr;  不能被访问
        [o reportf];
        
        NSLog(@"--------- 继承 --------");
        SubClass *sb = [[SubClass alloc] init];
        sb.className = @"SubClass.h";
        sb->_classInt = 30;
        [sb reportf]; //// 从方法 继承来的classStr 私有变量可通过方法访问;
        [sb show];
        
        NSLog(@"--------- 多态 --------");
        SubClass *bp = [[SubClass alloc]init];
        [bp print];
        SubClass1 *cp = [[SubClass1 alloc]init];
        [cp print];
        
        // 父类接收子类的实例,多态特性
        OODemo *op = [[SubClass alloc]init];
        [op print];
        
        
        
        
        
        
        
        
        
        
    }
    return 0;
}
