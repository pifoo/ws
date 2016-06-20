//
//  main.m
//  les1 征战Objective-C ：http://www.imooc.com/learn/218
//
//  Created by pifoo on 15/12/6.
//  Copyright © 2015年 何万江. All rights reserved.
//

#import <Foundation/Foundation.h>

// 自定义函数
double mianji(double x, double y){
    return x * y;
}
void show(){
    NSLog(@"this is a test .... ");
}


int main(int argc, const char * argv[]) {

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"征战Objective-C ：");
        
        
        // 对 main 函数参数的理解
        NSLog(@"argc =  %d : ", argc);                      // argc : 程序(命令) + 参数 的长度   > 例：ls -l -a (agrc = 3)
        for (int g =0; g < argc; g++) {
            NSLog(@"argv[] = %s : ", argv[g]);              // argv[] : argv[0] ＝ ls , argv[1] ＝ -l, argv[2] ＝ -a
        }
        
        
        
        
        int a,b;                                            // 不显示声明，则默认值为0
        a=5,b=5;
        int c=(a+b) % 3;                                    // 取余
        NSLog(@"(a+b)/3取余 = %d ;",c);                      // 格式化输出
        
        NSLog(@"a++ = %d ",a++);                            // 先取值后加
        NSLog(@"++b = %d ",++b);                            // 先加再取值
        
        if((2)){                                            // if只要不是0就是true , 也可以是字符串 等
            NSLog(@"true .");
        }else{
            NSLog(@"false .");
        }
        
        
            int i=0;
        j:{                  // 可省略大括号
            i++;
            NSLog(@"i的值是: %d",i);
        }
            if(i<=5){        // 可省略大括号
                goto j;                                         // 高级跳转语句, 如果 i<5 ,则跳转到 j 继续执行
            }else{
                goto k;
            }
        k:{
            NSLog(@"跳远了.....");
        }
        
        
        int n=0;
        while (n<5) {                                           // while = if + goto
            NSLog(@"while .... n %d ",n++);
        }
        
        
        int m=0;
        do{                                                     // 至少执行一次
            m++;
            if(m % 2 == 0){
                continue;                                       // 跳出当前语句继续执行
            }
            NSLog(@"do .... m %d ",m);
        }while (m<10);
        
        
        for (int l=0; l<50; l++) {
            
            if (l == 6) {
                break;                                          // 终止执行
            }
            NSLog(@"for .... l %d",l);
        }
        
        
        int t = 13;
        switch (t%5) {
            case 3:
                NSLog(@"13/5取余 %d ",t%5);
                break;
            default:
                NSLog(@"不满足条件，swithc结束。");
                break;
        };
        
        
        // 函数的调用
        double mj = mianji(5.0, 5.0);
        NSLog(@"%f",mj);
        
        for(int s=0; s<3; s++){
            show();
        }
        
        
        
    }
    
    
    
    return 0;
}






