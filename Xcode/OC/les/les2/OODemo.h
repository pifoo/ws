//
//  OODemo.h
//  les
//
//  Created by pifoo on 15/12/30.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OODemo : NSObject
{
    /**
     * 成员变量的访问级别（封装性）
     * public - 公有（类内、类外都可以 被访问 和 被继承）
     * private - 私有（受限于类内访问）
     * protected - 默认 受保护（类内可以使用，类外无法访问和被继承）
     * package - 框架权限（在框架内受保护，在框架外私有）
     */
    @public
    int _classInt;
    
    @private
    NSString *_classStr;
    
    @protected
    NSString *_classStr1;
    
    @package
}


@property(nonatomic,strong)NSString *className;

// OC中方法是没有访问修饰符的，同C语言
// OC中没有方法重载，有方法重写
- (void)reportf;

- (void)print;



@end
