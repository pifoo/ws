//
//  main.cpp
//  les1
//
//  Created by pifoo on 15/12/6.
//  Copyright © 2015年 何万江. All rights reserved.
//

#include <iostream>
#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello world!");                   // 教科书的写法
    puts("Hello world!");                     // 我最喜欢的
    puts("Hello" " " "world!");               // 拼接字符串
    std::cout << "Hello world!" << std::endl; // C++风格的教科书写法
    
    std::cout << "Hello, World!\n";
    return 0;
}

