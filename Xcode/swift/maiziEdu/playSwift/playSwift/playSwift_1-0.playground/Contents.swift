//: Playground - noun: a place where people can play
//: videoUrl:http://www.imooc.com/learn/127

import Cocoa

var str = "Hello, playground"


// i的n次方曲线
for i in -20 ... 20 {
    var j = i * i;
    var k = i * i * i;
    var l = i * i * i * i * i;
}


// 傅立叶变换脉冲波
var m = -6.28;
while m < 6.28 {
    var s1 = 4*sin(m) / 3.14
    var s2 = 4*sin(3*m) / (3*3.14)
    var s3 = 4*sin(5*m) / (5*3.14)
    var s4 = 4*sin(7*m) / (7*3.14)
    
    s1
    s1 + s2
    s1 + s2 + s3
    s1 + s2 + s3 + s4
    
    m += 0.1
}


// 二分查找法
func binarySearch(target:Int)->Int{
    
    var min_num = 0, max_num = 10000;
    var mid_num:Int;
    
    while(min_num < max_num){
        mid_num = (min_num + max_num)/2;
        
        if mid_num == target{
            return mid_num;
        }else if mid_num > target{
            max_num = mid_num - 1;
        }else{
            min_num = mid_num + 1;
        }
    }
    return -1;
    
}
binarySearch(5555);






















