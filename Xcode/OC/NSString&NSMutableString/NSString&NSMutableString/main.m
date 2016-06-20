//
//  main.m
//  NSString&NSMutableString
//
//  Created by pifoo on 16/1/1.
//  Copyright © 2016年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        /**
         *  C,OC字符串类型转换
         */
        char *c                                                 = "Hello , c . ";
        NSString *oc                                            = @"Hello , oc . ";
            // C -> OC
        NSString *str1                                          = [NSString stringWithUTF8String:c];
        NSLog(@"str1 - %@ ",str1);
            // OC -> C
        NSLog(@"str2 - %s ",[oc UTF8String]);
        
        /**
         *  创建字符串
         */
        NSString *str3                                          = @"iOS";    // 不需要自己释放内存
        
        NSString *str4                                          = [[NSString alloc]init];
        str4                                                    = @"swift";
        
        
        /**
         *  格式化字符串
         */
        int a                                                   = 10;
        int b                                                   = 20;
        NSString *str5 = [NSString stringWithFormat:@"a = %d, b = %d ",a,b];
        NSLog(@"str5 - %@",str5);
        
        /**
         *  拼接字符串
         */
        NSString *str6                                          = [str4 stringByAppendingString:str3];
        NSLog(@"str6 - %@ ",str6);
        
        /**
         *  大小写转换
         */
            // 转换为 小写
        NSString *str7                                          = @"aBcDeF";
        NSString *str8                                          = [str7 lowercaseString];
        NSLog(@"str8 - %@",str8);
        NSString *str9                                          = [str7 uppercaseString];
        NSLog(@"str9 - %@",str9);
        
        /**
         *  前缀、后缀的判断
         */
        NSString *str10                                         = @"www.imook.com";
            // 判断前缀
        BOOL haxPreFix                                          = [str10 hasPrefix:@"www."];
        if (haxPreFix) {
            NSLog(@"www.imook.com 前缀：www. ");
        }else{
            NSLog(@"www.imook.com 没有前缀：www. ");
        }
        
            // 判断后缀
        BOOL haxSufFix                                          = [str10 hasSuffix:@".com"];
        if (haxSufFix) {
            NSLog(@"www.imook.com 后缀：.com ");
        }else{
            NSLog(@"www.imook.com 没有后缀：.com ");
        }
        
            // 判断两个字符串是否相同
        NSString *str11                                         = @"Hello,11";
        NSString *str12                                         = @"Hello,112";
        if ([str11 isEqualToString:str12])
            NSLog(@"两个字符串相等");
        else
            NSLog(@"两个字条串不等");
        
            // 比较字符串
            // NSComparisonResult
        
        /**
         *  分隔
         */
            // 1. 按照指定字符分隔
        NSString *str13                                         = @"a,b,c,d,e";
        NSArray *strArray                                       = [str13 componentsSeparatedByString:@","];
        for (NSString *s in strArray) {
            NSLog(@"s - %@ ",s);
        }
            // 2. 按时范围截取
        NSRange range                                           = NSMakeRange(1, 5);
        NSString *str14                                         = [str13 substringWithRange:range];
        NSLog(@"str13 - %@ ",str14);
            // 3. 从指定位置开始截取
        NSString *str15                                         = [str13 substringFromIndex:2];
        NSLog(@"str15 - %@ ",str15);
            // 4. 截取到指定位置 - str14 substringToIndex:<#(NSUInteger)#>
        
        /**
         *  拆分字符串为每一个字符
         */
        for(int i                                               = 0; i < [str13 length];i ++){
            NSLog(@"%c ",[str13 characterAtIndex:i]);
        }
        
        /**
         *  查找
         */
        NSString *str16                                         = @"ab cd ef gh ij ab";
            // 1. 查找指定字符串的位置(正向查找，只会查出前面的字条串)
        NSRange range1                                          = [str16 rangeOfString:@"ab"];
        NSLog(@"range1.location - %ld ,range1.length - %ld ",range1.location,range1.length);
        
        /**
         *  替换   str16 stringByReplacingOccurrencesOfString:<#(nonnull NSString *)#> withString:<#(nonnull NSString *)#> @源字符串要被替换的内容  @替换的内容
         *              str16 stringByReplacingCharactersInRange:<#(NSRange)#> withString:<#(nonnull NSString *)#>
         */
        
        
        /**
         *  读取文件
         *  文件来源  -  1. 本地文件   2. 网络文件
         *  路径类
         */
        
        NSString *str17                                         = @"https://www.baidu.com";
        
            // 1. 本地文件
        // NSURL *fileUrl                                       = [NSURL fileURLWithPath:@"/Users/pifoo/workspaces/Xcode/OC/NSString&NSMutableString/NSString&NSMutableString/hello.txt"];
        
        NSString *fileStr                                       = [NSString stringWithContentsOfFile:@"/Users/pifoo/workspaces/Xcode/OC/NSString&NSMutableString/NSString&NSMutableString/hello.txt" encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"fileStr - %@ ",fileStr);
        
        
        
            // 2. 网络文件
        NSURL *httpUrl                                          = [NSURL URLWithString:str17];
        NSString *httpStr                                       = [NSString stringWithContentsOfURL:httpUrl encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"httpStr - %@ ",httpStr);
        
        
        /**
         *  写文件
         */
        BOOL isOk                                               = [str17 writeToFile:@"/Users/pifoo/workspaces/Xcode/OC/NSString&NSMutableString/NSString&NSMutableString/text.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (isOk)
            NSLog(@"写入成功.");
        else
            NSLog(@"写入成功.");
        
        
        
        
        
        /**
         *  NSMutableString - 可变字符串 https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMutableString_Class/index.html
         *  |- NSObject
         *      |- NSString
         *          |- CSLocalizedString
         *          |- NSMutableString
         */
        NSMutableString *s                                      = [[NSMutableString alloc]initWithCapacity:10];  // 10 - 字符串大小
        [s setString:@"Hello,"];
        NSLog(@"s - %@ ",s);
            // 1. 追加字符串
        [s appendString:@" NSMutableString ."];
        NSLog(@"s - %@ ",s);
            // s appendFormat:<#(nonnull NSString *), ...#>
            // 2. 替换字符串
            // s replaceCharactersInRange:<#(NSRange)#> withString:<#(nonnull NSString *)#>
        
        
        
        /**
         *  数组  - OC的数组可以存储不同类型的对象，只能存储对象
         *  https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/index.html#//apple_ref/occ/cl/NSArray
         */
        NSArray *a1                                             = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
            // 数组的长度
        int *count                                              = (int)a1.count;
            // 判断数组是是否包含对应的对象
        BOOL isHave                                             = [a1 containsObject:@"2"];
        if (isHave) {
            NSLog(@"存在");
        }else{
            NSLog(@"不存在");
        }
            // 返回数组中最后一个元素
        NSString *str                                           = [a1 lastObject];
        NSLog(@"a - >str lastObject : %@ ",str);
            // [a1 firstObject]
            // [a1 objectAtIndex:3] 取得指定索引位置的元素
            // [a1 indexOfObject:@"2"] 返回对象索引
        
        /**
         数组的遍历
         1. for i - 下标循环
         2. for in - 快速枚举
         3. 枚举器（迭代器）
         */
        
            // 1.
        for(int i                                               = 0; i < a1.count; i ++){
            NSLog(@"a1 - %@",[a1 objectAtIndex:i]);
        }
            // 2. 快速枚举（数组元素类型必须一致）
        for (NSString *a in a1) {
            NSLog(@"a1 - %@",a);
        }
        
        
        /**
         *  NSMutableArray - 可变数组
         *  https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/index.html#//apple_ref/occ/cl/NSMutableArray
         */
        Person *p1                                              = [[Person alloc]initWithName:@"pifoo"];
        Person *p2                                              = [[Person alloc]initWithName:@"hewj"];
        Person *p3                                              = [[Person alloc]initWithName:@"aasum"];
        NSMutableArray *mutableArray                            = [[NSMutableArray alloc]init];
            // 添加单个元素
        [mutableArray addObject:p1];
            // 添加数组到可变数组
        NSArray *ars                                            = [[NSArray alloc]initWithObjects:p2,p3, nil];
        [mutableArray addObjectsFromArray:ars];
            // 移除指定元素
        [mutableArray removeObject:p2];
            // 交换元素的位置
        [mutableArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
        NSLog(@"mutableArray - %@",mutableArray);
        
        
        /**
         *  字典 - 存储的内存不是连续的，用key,value进行对应（键值），（kvc - 键值编码）
         *  NSDictionary -
         *  NSMutableDictionary -
         */
        NSDictionary *d1 = [NSDictionary dictionaryWithObject:@"1" forKey:@"a"];
        NSLog(@"d1 - %@",d1);
        NSDictionary *d2 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil] forKeys:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", nil]];
        NSLog(@"d2 - %@",d2);
        NSDictionary *d3 = @{
                             @"a":@"1",
                             @"b":@"2",
                             @"c":@"3",
                             @"d":@"4"
                             };
        NSLog(@"d3 - %@",d3);
        int count1                                              = (int)[d3 count];
        NSLog(@"d3 count - %d ",count1);
        NSString *value                                         = [d3 valueForKey:@"c"];
        NSLog(@"value - %@",value);
        NSLog(@"value - %@",[d3 objectForKey:@"b"]);
        NSLog(@"allValues - %@ ",[d3 allValues]);
        NSArray *ars2                                           = [d1 objectsForKeys:[NSArray arrayWithObjects:@"a",@"b", nil] notFoundMarker:@"nou font."];
        NSLog(@"strs - %@",ars2);
            // 遍历字典
        NSEnumerator *en = [d3 keyEnumerator];
        id key = nil;
        while (key = [en nextObject]) {
            NSLog(@"key - %@",key);
        }
            // [d3 enumerateKeysAndObjectsUsingBlock:<#^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)block#>];
        
            // 可变字典
        NSMutableDictionary *nsmd = [[NSMutableDictionary alloc]init];
            // 添加键值对
        [nsmd setObject:@"1" forKey:@"a"];
        [nsmd setObject:@"2" forKey:@"b"];
        
        [nsmd removeObjectForKey:@"a"];
        
        NSLog(@"nsmd - %@", nsmd);
        

        
        
    }
    return 0;
}
