#!/usr/bin/env python3
#coding:utf-8
# Filename : python_04_oop_01.py
# print("python IO...")
#

try:
	f = open('test.txt', 'r')
	print(f.read())
finally:
    if f:
    	f.close()

# 每次都这么写实在太繁琐，所以，Python引入了with语句来自动帮我们调用close()方法：
with open('test.txt', 'r') as f:
    print(f.read())


# 二进制文件
# 用'rb'模式打开文件即可
# 
# 写文件
f = open('test.txt', 'w')
f.write('Hello, world!')
f.close()

with open('test.txt', 'w') as f:
    f.write('Hello,world!')


# StringIO和BytesIO       在内存中读写
# 把str写入StringIO
from io import StringIO
f = StringIO()	# 先创建一个StringIO
f.write('hello')
print(f.getvalue())

# 读取StringIO
from io import StringIO
f = StringIO('Hello!\nHi!\nGoodbye!')
while True:
	s = f.readline()
	if s == '':
		break
	print(s.strip())


# 操作文件和目录
import os
print(os.name) # 操作系统类型
print(os.uname()) # 系统详细信息
print(os.environ) # 环境变量 
print(os.environ.get('HOME')) # 获取某个环境变量的值
print(os.path.abspath('.')) # 查看当前目录的绝对路径

# 在某个目录下创建一个新目录，首先把新目录的完整路径表示出来:
os.path.join('/Users/pifoo/workspaces/python', 'testdir')
# 然后创建一个目录:
os.mkdir('/Users/pifoo/workspaces/python/testdir')
# 删掉一个目录:
os.rmdir('//Users/pifoo/workspaces/python/testdir')

# 对文件重命名:
# os.rename('test.py', 'test.txt')
# 删掉文件:
# os.remove('test.py')
# 用Python的特性来过滤文件。比如我们要列出当前目录下的所有目录，只需要一行代码：
print([x for x in os.listdir('.') if os.path.isdir(x)])
# 要列出所有的.py文件，也只需一行代码：
print([x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1]=='.py'])


# 序列化
# 把变量从内存中变成可存储或传输的过程称之为序列化，在Python中叫pickling
# 把变量内容从序列化的对象重新读到内存里称之为反序列化，即unpickling
# 把一个对象序列化并写入文件
import pickle
d = dict(name='Bob', age=20, score=88)
# 方法把任意对象序列化成一个bytes，然后，就可以把这个bytes写入文件。
# 或者用另一个方法pickle.dump()直接把对象序列化后写入一个file-like Object
pickle.dumps(d)
f = open('dump.txt', 'wb')
pickle.dump(d, f)
f.close()
# 当我们要把对象从磁盘读到内存时，可以先把内容读到一个bytes，然后用pickle.loads()方法反序列化出对象，
# 也可以直接用pickle.load()方法从一个file-like Object中直接反序列化出对象。
# 我们打开另一个Python命令行来反序列化刚才保存的对象：
f = open('dump.txt', 'rb')
d = pickle.load(f)   # 反序列化
f.close()
print(d)

# JSON
# 把Python对象变成一个JSON：
import json
d = dict(name='Bob', age=20, score=88)
print(json.dumps(d))
# 要把JSON反序列化为Python对象，用loads()或者对应的load()方法，
# 前者把JSON的字符串反序列化，
# 后者从file-like Object中读取字符串并反序列化：
json_str = '{"age": 20, "score": 88, "name": "Bob"}'
print(json.loads(json_str))








