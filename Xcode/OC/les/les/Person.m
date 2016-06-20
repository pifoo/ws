//
//  Person.m
//  les
//
//  Created by pifoo on 16/1/12.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import "Person.h"

@implementation Person
//-(void)setAge:(int)age
//{
//    _age = age; //如果.h文件中没有声明成员变量，会自动生成私有的带下划线的成员变量
//}
//-(int)age
//{
//    return _age;
//}

    // 重写 -init
//- (instancetype)init{
//    
//    self = [super init];
//    
//    if (self != nil) {
//        _age = 20;
//    }
//    
//    return self;
//    
//}
    // =>简写
- (instancetype)init{
    
    if (self = [super init]) {
        _age = 20;
    }
    
    return self;
    
}


@end
