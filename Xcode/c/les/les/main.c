//
//  main.c
//  les1
//
//  Created by pifoo on 15/12/6.
//  Copyright © 2015年 何万江. All rights reserved.
//

#include <stdio.h>


struct student
{
    char name[20];
    int age;
};

int main(int argc, const char * argv[]) {
    // insert code here...
    struct student Result = {"XiaoMing", 12};
    
    printf("%s\n\n\n", Result.name);
    printf("%d\n", Result.age);
    
    printf("Hello, World!\n");
    
    
    
    
    return 0;
}
