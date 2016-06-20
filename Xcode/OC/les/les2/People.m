//
//  People.m    类的实现
//  les
//
//  Created by pifoo on 15/12/28.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import "People.h"

@implementation People
{
    NSString *_peopleName;
    int *_peopleAge;     // 属性
    
}

//@synthesize peopleName = _peopleName;  可省略，SDK支持

// 重写初始init方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 类内调用成员变量，而不是属性, 属性是给类外使用的
        
        // 因在 声明了属性：peopleName（@property(nonatomic, strong) NSString *peopleName;），则会自动生成成员变量： _peopleName
        // 实例化时初始值
        _peopleName = @"pifoo";
        _peopleAge = 30;
        
        
    }
    return self;
}


    //@synthesize


// 自定义初始化方法
- (instancetype)initWithPeopleName:(NSString *) peopleName andPeopleAge:(int)peopleAge
{
    self = [super init];
    if (self) {
        _peopleName = peopleName;
        _peopleAge = peopleAge;
    }
    return self;
}

// 一个属性对应两个方法：
/*
- (void) setName:(NSString *)name
{
    _peopleName = name;
}
- (NSString *)getName{
    return _peopleName;
}
*/




static NSString *_peopleName1;       // 静态变量

// 实现方法（ 对象方法
- (int)report
{
    //[People report1];                    // 对象方法中 ： 调用类方法
    //_peopleName = @"He";                 // - 方法中 可调用成员变量
    NSLog(@"peopleName = %@",_peopleName);
    NSLog(@"peopleAge = %d",_peopleAge);
    
    return 20;
    
}
+ (void)report1 // 类方法
{
    NSLog(@"+ 号：report1 ");
    //[[People alloc] report];      // 类方法中 ：调用对象方法 先实例化
    // _peopleName;                 + 方法中 不能调用成员变量
    _peopleName1 = @"123";          // + 方法中 可调用静态方法
}


- (int)showWithA:(int)a
{
    return a;
}
- (int)showWithA:(int)a :(int)b{
    return a * b;
}
- (int)showWithA:(int)a andB:(int)b
{
    return a + b;
}













@end
