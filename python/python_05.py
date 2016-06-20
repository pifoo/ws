#!/usr/bin/env python3
#coding:utf-8
# Filename : python_04_oop_01.py 
# 
# print("python 错误、调试和测试")
#

def foo():
    r = some_function()
    if r==(-1):
        return (-1)
    # do something
    return r

def bar():
    r = foo()
    if r==(-1):
        print('Error')
    else:
        pass

# try...except...finally...
# try
# 让我们用一个例子来看看try的机制：

try:
    print('try...')
    r = 10 / 0
    print('result:', r)
except ZeroDivisionError as e:
    print('except:', e)
finally:
    print('finally...')
print('END')

# 可以有多个except来捕获不同类型的错误：
try:
    print('try...')
    r = 10 / int('a')
    print('result:', r)
except ValueError as e:
    print('ValueError:', e)
except ZeroDivisionError as e:
    print('ZeroDivisionError:', e)
finally:
    print('finally...')
print('END')

# 如果没有错误发生，可以在except语句块后面加一个else，当没有错误发生时，会自动执行else语句：
try:
    print('try...')
    r = 10 / int('2')
    print('result:', r)
except ValueError as e:
    print('ValueError:', e)
except ZeroDivisionError as e:
    print('ZeroDivisionError:', e)
else:
    print('no error!')
finally:
    print('finally...')
print('END')

# Python的错误其实也是class，所有的错误类型都继承自BaseException，所以在使用except时需要注意的是，
# 它不但捕获该类型的错误，还把其子类也“一网打尽”。比如：
'''try:
    foos()
except ValueError as e:
    print('ValueError')
except UnicodeError as e:
    print('UnicodeError')'''

# Python内置的logging模块可以非常容易地记录错误信息：
import logging

def foo(s):
    return 10 / int(s)

def bar(s):
    return foo(s) * 2

def main():
    try:
        bar('0')
    except Exception as e:
        logging.exception(e)

main()
print('END')
