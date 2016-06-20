//
//  Person.m
//  NSString&NSMutableString
//
//  Created by pifoo on 16/1/3.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _personName = name;
    }
    return self;
}
@end
