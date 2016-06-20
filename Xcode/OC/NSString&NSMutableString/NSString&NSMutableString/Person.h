//
//  Person.h
//  NSString&NSMutableString
//
//  Created by pifoo on 16/1/3.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,strong)NSString *personName;
- (instancetype)initWithName:(NSString *)name;

@end
