//
//  People.h    类的声明
//  les
//
//  Created by pifoo on 15/12/28.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>                               // #include " "     C语言引入头文件语句

/*
 * 成员变量（固有的特性，类内 使用成员变量）<br>
 * 属性（类外 使用属性 ）
 *
 */

@interface People : NSObject
/*
 * 成员变量声明可省略，当声明了属性，SDK会自动生成
{
    // @public                                                     // 访问级别
    // 声明 成员变量          只能在 类内使用，@public 改变访问级别可使类外访问
    
    //NSString *_peopleName;
    int _peopleAge;
    int _peopleSex;

}
 */

// 属性 为了让类外可以访问成员变量 ： 属性 就是成员变量的外部接口
//自动生成成员变量的声明（setter,getter）
@property(nonatomic, strong) NSString *peopleName;
// 一个属性对应两个方法：
//- (void) setName:(NSString *)name;
//- (NSString *)getName;


/* 
 * 声明方法
 * 1: +,-
 * - 、+ :方法的类型 （-：代表对象方法(用对象名来调用)，+：代表类方法(用类名来调用)）
 * + 类方法：静态方法
 * - 对象方法：非静态方法
 * (+、- 方法可以互相调用：需要类名和实例化，+ 方法不能调用成员变量)
 * 2: (void) - 返回值
 * 3: 参数 - :(int)a ：    :代表有参数； (int)代表参数类型； a代表参数名；
 * 4: 方法名 - :   showWithA:(冒号属于方法名一部分)   方法名是去掉返回值类型，参数类型，参数名后剩下的部分
 */
- (int)report;
+ (void)report1;
- (int)showWithA:(int)a;
- (int)showWithA:(int)a :(int)b;
// 方法名 showWithA: andB:
- (int)showWithA:(int)a andB:(int)b; // 方法名 — showWithA: andB:


// 重写初始化方法
//- (id)init;                   // id类型 属万能类型
- (instancetype)init;           // instancetype 表示当前类的类型

// 自定义初始化方法
- (instancetype)initWithPeopleName:(NSString *) peopleName andPeopleAge:(int)peopleAge;





@end
