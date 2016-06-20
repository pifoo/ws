//
//  main.c
//  les1
//
//  Created by pifoo on 15/12/6.
//  Copyright © 2015年 何万江. All rights reserved.
//

#include <stdio.h>
#include <string.h>
    // 基本数据类型：int, float, double, char
    // 构造类型：Arrar,
#pragma mark - 标记：今天就写到这 （- : 分组）

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    
        //double a = 10.5;
    
        //sizeof(<#expression-or-type#>);
    printf("在内存中所占字节数：%lu\n",sizeof(double));
    
    int size  = strlen("哈hello");
    printf("字符数：%d\n",size);
    
#pragma mark printf()
        // \0 的作用 : 字符串结束的标志
    char name[] = "it";
    char name2[] = {'o','k'};
    char name3[] = {'o','k','\0'};
    printf("%s\n",name);
    printf("%s\n",name2);//????????  name2为字符串数组的内存地址
    printf("%s\n",name3);
    
    printf("%s\n",&name3[1]);//!!!!!
    
#pragma mark - 标记：今天就写到这
    
    
    
    return 0;
}
