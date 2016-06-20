//
//  main.m
//  les1
//
//  Created by pifoo on 15/12/5.
//  Copyright © 2015年 何万江. All rights reserved.
//  iOS苹果表开发攻略 http://www.imooc.com/course/programdetail/pid/46
//  征战Objective-C http://www.imooc.com/learn/218
// http://www.cnblogs.com/kenshincui/
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 构造方法：用来初始化对象的方法: -init
        
        /**
         * 实例化一个对象： //Person *p = [Person new];
         * 1. 分配存储空间；   +alloc
         * 2. 初始化；  -init
         */
        //Person *p = [[Person alloc]init];
        
        Student *s = [[Student alloc]init];
        
        // p.age = 10; // [p setAge:10];
        
        NSLog(@"s.no - %d , s.age - %d",s.no, s.age); // [p age]
        
        
        NSLog(@"s - 指针变量的地址：%p",&s);
        NSLog(@"s - 对象的地址：%p",s);
        NSLog(@"s - <类名：对象地址>：%@",s);
        
        NSLog(@"行号 - %d",__LINE__);
        NSLog(@"文件名(包含路径) - %s",__FILE__);
        NSLog(@"当前函数名 - %s",__func__);
        NSLog(@"当前函数名 - %s",__FUNCTION__);

        

        
        
    }
    return 0;
}
