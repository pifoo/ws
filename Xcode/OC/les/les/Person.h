//
//  Person.h
//  les
//
//  Created by pifoo on 16/1/12.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
//{
//    int _age;
//}
/**
 *  @property int age;
 *  仅此一句，编译器可自动完成：
 *  1. 定义成员变量: ina _age;
 *  2. .h文件->声明: setter,getter方法:
 *      -(void)setAge:(int)age;
 *      -(int)age;
 *  3. .m文件->实现: setter,getter方法:
 *
 */
@property int age;
//-(void)setAge:(int)age;
//-(int)age;


@end
