#!/usr/bin/env python3
# -*- coding: utf-8 -*- 
# Filename : python_04_oop_01.py 
# 
print('\n python oop \n')

# 正常情况下，当我们定义了一个class，创建了一个class的实例后，我们可以给该实例绑定任何属性和方法，这就是动态语言的灵活性。
# 先定义class：
class Student(object):
    pass
# 然后，尝试给实例绑定一个属性：
s = Student()
s.name = 'Michael' # 动态给实例绑定一个属性
print(s.name)
# 还可以尝试给实例绑定一个方法：
def set_age(self, age): # 定义一个函数作为实例方法
	self.age = age

from types import MethodType
s.set_age = MethodType(set_age, s) # 给实例绑定一个方法
s.set_age(25) # 调用实例方法
print(s.age) # 测试结果
# 但是，给一个实例绑定的方法，对另一个实例是不起作用的：
# s2 = Student() # 创建新的实例
# s2.set_age(25) # 尝试调用方法
# 
# 为了给所有实例都绑定方法，可以给class绑定方法：
def set_score(self, score):
	self.score = score
Student.set_score = MethodType(set_score, Student)
# 给class绑定方法后，所有实例均可调用：
s.set_score(100)
print(s.score)
# s2.set_score(99)
# print(s2.score)
# 通常情况下，上面的set_score方法可以直接定义在class中，
# 但动态绑定允许我们在程序运行的过程中动态给class加上功能，这在静态语言中很难实现
# 
# 使用__slots__
'''但是，如果我们想要限制class的属性怎么办？比如，只允许对Student实例添加name和age属性。
为了达到限制的目的，Python允许在定义class的时候，定义一个特殊的__slots__变量，来限制该class能添加的属性
'''
class Student(object):
    __slots__ = ('name', 'age') # 用tuple定义允许绑定的属性名称
s = Student() # 创建新的实例
s.name = 'Michael' # 绑定属性'name'
s.age = 25 # 绑定属性'age'
#  s.score = 99 # 绑定属性'score'
'''由于'score'没有被放到__slots__中，所以不能绑定score属性，试图绑定score将得到AttributeError的错误。
使用__slots__要注意，__slots__定义的属性仅对当前类起作用，对继承的子类是不起作用的：
'''
class GraduateStudent(Student):
	pass
g = GraduateStudent()
g.score = 9999
# 除非在子类中也定义__slots__，这样，子类允许定义的属性就是自身的__slots__加上父类的__slots__


## 使用@property
# Python内置的@property装饰器就是负责把一个方法变成属性调用的
class Student(object):
    @property
    def score(self):
        return self._score
    @score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100!')
        self._score = value
# @property的实现比较复杂，我们先考察如何使用。把一个getter方法变成属性，
# 只需要加上@property就可以了，此时，@property本身又创建了另一个装饰器@score.setter，
# 负责把一个setter方法变成属性赋值，于是，我们就拥有一个可控的属性操作
s = Student()
s.score = 60 # OK，实际转化为s.set_score(60)
s.score # OK，实际转化为s.get_score()
# s.score = 9999

# 还可以定义只读属性，只定义getter方法，不定义setter方法就是一个只读属性：
class Student(object):
    @property
    def birth(self):
        return self._birth
    @birth.setter
    def birth(self, value):
        self._birth = value
    @property
    def age(self):
        return 2015 - self._birth
# 上面的birth是可读写属性，而age就是一个只读属性，因为age可以根据birth和当前时间计算出来

# 小结
# @property广泛应用在类的定义中，可以让调用者写出简短的代码，同时保证对参数进行必要的检查，这样，程序运行时就减少了出错的可能性。




## 多重继承
class Animal(object):
    pass

# 大类:
class Mammal(Animal):
    pass

class Bird(Animal):
    pass

# 各种动物:
class Dog(Mammal):
    pass

class Bat(Mammal):
    pass

class Parrot(Bird):
    pass

class Ostrich(Bird):
    pass

class Runnable(object):
    def run(self):
        print('Running...')

# 现在，我们要给动物再加上Runnable和Flyable的功能，只需要先定义好Runnable和Flyable的类
class Flyable(object):
    def fly(self):
        print('Flying...')


# 对于需要Runnable功能的动物，就多继承一个Runnable，例如Dog：
class Dog(Mammal, Runnable):
    pass
# 对于需要Flyable功能的动物，就多继承一个Flyable，例如Bat：
class Bat(Mammal, Flyable):
    pass
# 通过多重继承，一个子类就可以同时获得多个父类的所有功能。

## MixIn
# MixIn的目的就是给一个类增加多个功能，这样，在设计类的时候，我们优先考虑通过多重继承来组合多个MixIn的功能，
# 而不是设计多层次的复杂的继承关系



## 定制类
#
# __str__
# 我们先定义一个Student类，打印一个实例：
class Student(object):
	def __init__(self, name):
		self.name = name
	def __str__(self):
		return 'Student object (name: %s)' % self.name
	__repr__ = __str__
# s = Student('Michael')
print(Student('Michael'))
# print (s)
'''
直接显示变量调用的不是__str__()，而是__repr__()，两者的区别是__str__()返回用户看到的字符串，
而__repr__()返回程序开发者看到的字符串，也就是说，__repr__()是为调试服务的
'''

# __iter__
# 如果一个类想被用于for ... in循环，类似list或tuple那样，就必须实现一个__iter__()方法，
# 该方法返回一个迭代对象，然后，Python的for循环就会不断调用该迭代对象的__next__()方法拿到循环的下一个值，直到遇到StopIteration错误时退出循环。
# 我们以斐波那契数列为例，写一个Fib类，可以作用于for循环：
class Fib(object):
    def __init__(self):
        self.a, self.b = 0, 1 # 初始化两个计数器a，b
    def __iter__(self):
        return self # 实例本身就是迭代对象，故返回自己
    def __next__(self):
        self.a, self.b = self.b, self.a + self.b # 计算下一个值
        if self.a > 100000: # 退出循环的条件
            raise StopIteration();
        return self.a # 返回下一个值
for n in Fib():
	print(n)


# __getitem__
# Fib实例虽然能作用于for循环，看起来和list有点像，但是，把它当成list来使用还是不行，比如，取第5个元素：
# Fib()[5]
# 要表现得像list那样按照下标取出元素，需要实现__getitem__()方法：
class Fib(object):
    def __getitem__(self, n):
        a, b = 1, 1
        for x in range(n):
            a, b = b, a + b
        return a
# 现在，就可以按下标访问数列的任意一项了：
f = Fib()
print(f[100])
# 但是list有个神奇的切片方法：
print(list(range(100))[5:10])
# 对于Fib却报错。原因是__getitem__()传入的参数可能是一个int，也可能是一个切片对象slice，所以要做判断：
class Fib(object):
    def __getitem__(self, n):
        if isinstance(n, int): # n是索引
            a, b = 1, 1
            for x in range(n):
                a, b = b, a + b
            return a
        if isinstance(n, slice): # n是切片
            start = n.start
            stop = n.stop
            a, b = 1, 1
            L = []
            for x in range(stop):
                if x >= start:
                    L.append(a)
                a, b = b, a + b
            return L
# 现在试试Fib的切片：
f = Fib()
print(f[0:5])
# 但是没有对step参数作处理：
print(f[0:10:2])

# __getattr__
# 正常情况下，当我们调用类的方法或属性时，如果不存在，就会报错。比如定义Student类：
class Student(object):
    def __init__(self):
        self.name = 'Michael'
s = Student()
print(s.name)
# print(s.score)
# 要避免这个错误，除了可以加上一个score属性外，Python还有另一个机制，
# 那就是写一个__getattr__()方法，动态返回一个属性。修改如下
class Student(object):
    def __init__(self):
        self.name = 'Michael'
    def __getattr__(self, attr):
        if attr=='score':
            return 99
# 当调用不存在的属性时，比如score，Python解释器会试图调用__getattr__(self, 'score')
# 来尝试获得属性，这样，我们就有机会返回score的值：
s = Student()
print(s.name)
print(s.score)
# 返回函数也是完全可以的：
class Student(object):
    def __getattr__(self, attr):
        if attr=='age':
            return lambda: 25
# 只是调用方式要变为：
# print(s.age())
'''注意，只有在没有找到属性的情况下，才调用__getattr__，已有的属性，比如name，不会在__getattr__中查找。
此外，注意到任意调用如s.abc都会返回None，这是因为我们定义的__getattr__默认返回就是None。
要让class只响应特定的几个属性，我们就要按照约定，抛出AttributeError的错误：'''
class Student(object):
    def __getattr__(self, attr):
        if attr=='age':
            return lambda: 25
        raise AttributeError('\'Student\' object has no attribute \'%s\'' % attr)

## __call__

# 一个对象实例可以有自己的属性和方法，当我们调用实例方法时，我们用instance.method()来调用。
# 能不能直接在实例本身上调用呢？在Python中，答案是肯定的。
# 任何类，只需要定义一个__call__()方法，就可以直接对实例进行调用。请看示例：
class Student(object):
    def __init__(self, name):
        self.name = name
    def __call__(self):
        print('My name is %s.' % self.name)
# 调用方式如下：
s = Student('Michael')
s()
'''
__call__()还可以定义参数。对实例进行直接调用就好比对一个函数进行调用一样，所以你完全可以把对象看成函数，把函数看成对象，因为这两者之间本来就没啥根本的区别。
如果你把对象看成函数，那么函数本身其实也可以在运行期动态创建出来，因为类的实例都是运行期创建出来的，这么一来，我们就模糊了对象和函数的界限。
那么，怎么判断一个变量是对象还是函数呢？其实，更多的时候，我们需要判断一个对象是否能被调用，能被调用的对象就是一个Callable对象，比如函数和我们上面定义的带有__call()__的类实例：
'''
'''
print(callable(Student()))
print(callable(max))
print(callable([1, 2, 3]))
print(callable(None))
print(callable('str'))'''
# 通过callable()函数，我们就可以判断一个对象是否是“可调用”对象




## 使用枚举类
# 当我们需要定义常量时，一个办法是用大写变量通过整数来定义，例如月份：
JAN = 1
FEB = 2
MAR = 3
#...
NOV = 11
DEC = 12
'''好处是简单，缺点是类型是int，并且仍然是变量。
更好的方法是为这样的枚举类型定义一个class类型，然后，每个常量都是class的一个唯一实例。
Python提供了Enum类来实现这个功能：'''
from enum import Enum
Month = Enum('Month', ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
# 这样我们就获得了Month类型的枚举类，可以直接使用Month.Jan来引用一个常量，或者枚举它的所有成员：
for name, member in Month.__members__.items():
    print(name, '=>', member, ',', member.value)
# value属性则是自动赋给成员的int常量，默认从1开始计数。
# 如果需要更精确地控制枚举类型，可以从Enum派生出自定义类：
from enum import Enum, unique
@unique # @unique装饰器可以帮助我们检查保证没有重复值。
class Weekday(Enum):
    Sun = 0 # Sun的value被设定为0
    Mon = 1
    Tue = 2
    Wed = 3
    Thu = 4
    Fri = 5
    Sat = 6
# 访问这些枚举类型可以有若干种方法：
day1 = Weekday.Mon
print(day1)
print(Weekday.Mon.value)
for name, member in Weekday.__members__.items():
	print(name, '=>', member)

# 小结
# Enum可以把一组相关常量定义在一个class中，且class不可变，而且成员可以直接比较。





## 使用元类
# type()
# metaclass，直译为元类，简单的解释就是
# 先定义metaclass，就可以创建类，最后创建实例
# 所以，metaclass允许你创建类或者修改类。换句话说，你可以把类看成是metaclass创建出来的“实例”。













