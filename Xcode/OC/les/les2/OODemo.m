//
//  OODemo.m
//  les
//
//  Created by pifoo on 15/12/30.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import "OODemo.h"


@implementation OODemo
- (void)reportf
{
    _classStr = @"classStr";
    NSLog(@"className - %@ ", _className);
    NSLog(@"classInt - %d ", _classInt);
    NSLog(@"classStr - %@ ", _classStr); 
}

- (void)print
{
    NSLog(@" OODemo 打印机 ");
}


@end
