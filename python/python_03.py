#!/usr/bin/python  
#coding:utf-8   
# Filename : python_03.py 
print '\n python 模块－－－－－－－－－－－－－－－－－－－－－－－－－－－－'

# 使用模块
# 我们以内建的sys模块为例，编写一个hello的模块

#!/usr/bin/env python
# -*- coding: utf-8 -*-

' a test module '   # 表示模块的文档注释，任何模块代码的第一个字符串都被视为模块的文档注释
__author__ = 'Michael Liao'	# 使用__author__变量把作者写进去

import sys
def test():
    args = sys.argv	# sys模块有一个argv变量，用list存储了命令行的所有参数。argv至少有一个元素，因为第一个参数永远是该.py文件的名称，
    if len(args)==1:
        print 'Hello, world!'
    elif len(args)==2:
        print 'Hello, %s!' % args[1]
    else:
        print 'Too many arguments!'

if __name__=='__main__':
    test()

print 








