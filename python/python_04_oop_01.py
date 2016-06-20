#!/usr/bin/env python3
# -*- coding: utf-8 -*- 
# Filename : python_04_oop_01.py 
# 
print('\n python oop \n')

# 假设我们要处理学生的成绩表，为了表示一个学生的成绩，
# 面向过程的程序可以用一个dict表示：
std1 = { 'name': 'Michael', 'score': 98 }
std2 = { 'name': 'Bob', 'score': 81 }
#而处理学生成绩可以通过函数实现，比如打印学生的成绩：
def print_score(std):
    print('%s: %s' % (std['name'], std['score']))
print_score(std1)
print_score(std2)

# 采用面向对象的程序设计思想，
class Student(object):	# (object) 表示该类继承object
    # __init__方法的第一个参数永远是self(实例变量)，表示创建的实例本身,可以把各种属性绑定到self
    def __init__(self, name, score): 
        self.name = name
        self.score = score
    def print_score(self):
        print('%s: %s' % (self.name, self.score))
    def get_grade(self):
        if self.score >= 90:
            return 'A'
        elif self.score >= 60:
            return 'B'
        else:
            return 'C'
bart = Student('Bart Simpson', 59)
lisa = Student('Lisa Simpson', 87)
bart.print_score()
print(bart.get_grade())
lisa.print_score()
print(lisa.get_grade())
# print(bart.__name)   # 通过实例变量访问内部属性


## 类和实例
# 定义类
class Student(object):
    pass
# 实例化对象
bart = Student()
print(bart)     # <__main__.Student object at 0x10328f4d0>
print(Student)  # <class '__main__.Student'>
# 可以自由地给一个实例变量绑定属性
bart.name = 'Bart Simpson'
print(bart.name)


## 访问限制
# 实例的变量名如果以__开头，就变成了一个私有变量（private），只有内部可以访问，外部不能访问
class Student(object):
    def __init__(self, name, score):
        self.__name = name
        self.__score = score
    def print_score(self):
        print('%s: %s' % (self.__name, self.__score))
bart = Student('Bart Simpson', 59)
lisa = Student('Lisa Simpson', 87)
bart.print_score()
lisa.print_score()
# print(bart.__name) # 无法访问内部私变量
# 但是如果外部代码要获取name和score怎么办？可以给Student类增加get_name和get_score这样的方法
class Student(object):
    def __init__(self, name, score):
        self.__name = name
        self.__score = score
    def print_score(self):
        print('%s: %s' % (self.__name, self.__score))
    # 但是如果外部代码要获取name和score怎么办？可以给Student类增加get_name和get_score这样的方法
    def get_name(self):
        return self.__name
    def get_score(self):
        return self.__score
    # 如果又要允许外部代码修改score怎么办？可以再给Student类增加set_score方法： 
    def set_score(self, score):
        if 0 <= score <= 100:
            self.__score = score
        else:
            raise ValueError('bad score')
# __xxx__   特殊变量，外部可以直接访问
bart = Student('Bart Simpson', 59)
lisa = Student('Lisa Simpson', 87)
bart.print_score()
lisa.print_score()
# 双下划线开头的实例变量是不是一定不能从外部访问呢？其实也不是。不能直接访问__name是因为Python解释器对外把__name变量改成了_Student__name，所以，仍然可以通过_Student__name来访问__name变量：
print(bart._Student__name)

## 继承和多态
class Animal(object):
    def run(self):
        print('Animal is running...')
# 当我们需要编写Dog和Cat类时，就可以直接从Animal类继承：
class Dog(Animal):
    def run(self): # 多态  
        print('Dog is running...')
    def eat(self):
        print('Eating meat...')

class Cat(Animal):
    def run(self):
        print('Cat is running...')

dog = Dog()
dog.run()
dog.eat()
cat = Cat()
cat.run()


# 多态
# 要理解多态的好处，我们还需要再编写一个函数，这个函数接受一个Animal类型的变量：
def run_twice(animal):
    animal.run()
    animal.run()
# 当我们传入Animal的实例时，run_twice()就打印出：
run_twice(Animal())
# 当我们传入Dog的实例时，run_twice()就打印出
run_twice(Dog())
# 当我们传入Cat的实例时，run_twice()就打印出：
run_twice(Cat())
# 现在，如果我们再定义一个Tortoise类型，也从Animal派生：
class Tortoise(Animal):
    def run(self):
        print('Tortoise is running slowly...')
# 当我们调用run_twice()时，传入Tortoise的实例：
run_twice(Tortoise())
'''
你会发现，新增一个Animal的子类，不必对run_twice()做任何修改，实际上，任何依赖Animal作为参数的函数或者方法都可以不加修改地正常运行，原因就在于多态。
多态的好处就是，当我们需要传入Dog、Cat、Tortoise……时，我们只需要接收Animal类型就可以了，因为Dog、Cat、Tortoise……都是Animal类型，然后，按照Animal类型进行操作即可。由于Animal类型有run()方法，因此，传入的任意类型，只要是Animal类或者子类，就会自动调用实际类型的run()方法，这就是多态的意思：
对于一个变量，我们只需要知道它是Animal类型，无需确切地知道它的子类型，就可以放心地调用run()方法，而具体调用的run()方法是作用在Animal、Dog、Cat还是Tortoise对象上，由运行时该对象的确切类型决定，这就是多态真正的威力：调用方只管调用，不管细节，而当我们新增一种Animal的子类时，只要确保run()方法编写正确，不用管原来的代码是如何调用的。
这就是著名的“开闭”原则：
# 对扩展开放：允许新增Animal子类；
# 对修改封闭：不需要修改依赖Animal类型的run_twice()等函数。
'''

## 静态语言 vs 动态语言
'''
对于静态语言（例如Java）来说，如果需要传入Animal类型，则传入的对象必须是Animal类型或者它的子类，否则，将无法调用run()方法。
对于Python这样的动态语言来说，则不一定需要传入Animal类型。我们只需要保证传入的对象有一个run()方法就可以了：
'''
class Timer(object):
    def run(self):
        print('Start...')
'''
这就是动态语言的“鸭子类型”，它并不要求严格的继承体系，一个对象只要“看起来像鸭子，走起路来像鸭子”，那它就可以被看做是鸭子。
Python的“file-like object“就是一种鸭子类型。对真正的文件对象，它有一个read()方法，返回其内容。但是，许多对象，只要有read()方法，都被视为“file-like object“。许多函数接收的参数就是“file-like object“，你不一定要传入真正的文件对象，完全可以传入任何实现了read()方法的对象。
'''



## 获取对象信息
# 当我们拿到一个对象的引用时，如何知道这个对象是什么类型、有哪些方法呢？
# 
# 使用type()
# 首先，我们来判断对象类型，使用type()函数：
# 基本类型都可以用type()判断：
print(type(123))
# 如果要判断一个对象是否是函数怎么办？可以使用types模块中定义的常量
import types
def fn():
    pass
print(type(fn)==types.FunctionType)
print(type(abs)==types.BuiltinFunctionType)
print(type(lambda x: x)==types.LambdaType)
print(type((x for x in range(10)))==types.GeneratorType)

# 
# 使用isinstance()
# 要判断class的类型，可以使用isinstance()函数
print(isinstance(dog,Animal))
# 实际类型是Dog的dog也是Animal类型
print(isinstance(dog, Dog) and isinstance(dog, Animal))
# 并且还可以判断一个变量是否是某些类型中的一种，比如下面的代码就可以判断是否是list或者tuple
print(isinstance([1, 2, 3], (list, tuple)))
print(isinstance((1, 2, 3), (list, tuple)))

#
# 使用dir()
# 如果要获得一个对象的所有属性和方法，可以使用dir()函数，它返回一个包含字符串的list，
# 比如，获得一个str对象的所有属性和方法
print(dir('ABC'))
print(dir(Dog))
# 仅仅把属性和方法列出来是不够的，配合getattr()、setattr()以及hasattr()，我们可以直接操作一个对象的状态
class MyObject(object):
    def __init__(self):
        self.x = 9
    def power(self):
        return self.x * self.x
obj = MyObject()
# 紧接着，可以测试该对象的属性：
print(hasattr(obj, 'x')) # 有属性'x'吗？
setattr(obj, 'y', 19) # 设置一个属性'y'
print(hasattr(obj, 'y')) # 有属性'y'吗？
print(getattr(obj, 'y')) # 获取属性'y'
# 可以传入一个default参数，如果属性不存在，就返回默认值：
print(getattr(obj, 'z', 404)) # 获取属性'z'，如果不存在，返回默认值404
# 也可以获得对象的方法：
print(hasattr(obj, 'power')) # 有属性'power'吗
print(getattr(obj, 'power')) # 获取属性'power'
fn = getattr(obj, 'power') # 获取属性'power'并赋值到变量fn
print(fn) # fn指向obj.power
print(fn())  # 调用fn()与调用obj.power()是一样的

# 一个正确的用法的例子如下：
def readImage(fp):
    if hasattr(fp, 'read'):
        return readData(fp)
    return None
'''
假设我们希望从文件流fp中读取图像，我们首先要判断该fp对象是否存在read方法，如果存在，则该对象是一个流，如果不存在，则无法读取。hasattr()就派上了用场。
请注意，在Python这类动态语言中，根据鸭子类型，有read()方法，不代表该fp对象就是一个文件流，它也可能是网络流，也可能是内存中的一个字节流，但只要read()方法返回的是有效的图像数据，就不影响读取图像的功能。
'''

## 实例属性和类属性
# 由于Python是动态语言，根据类创建的实例可以任意绑定属性。
# 给实例绑定属性的方法是通过实例变量，或者通过self变量：
class Student(object):
    def __init__(self, name):
        self.name = name

s = Student('Bob')
s.score = 90
# 类属性
# 但是，如果Student类本身需要绑定一个属性呢？可以直接在class中定义属性，这种属性是类属性，归Student类所有：
# 当我们定义了一个类属性后，这个属性虽然归类所有，但类的所有实例都可以访问到
class Student(object):
    name = 'Student'
s = Student() # 创建实例s
print(s.name) # 打印name属性，因为实例并没有name属性，所以会继续查找class的name属性
print(Student.name) # 打印类的name属性
s.name = 'Michael'  # 给实例绑定name属性
print(s.name) # 由于实例属性优先级比类属性高，因此，它会屏蔽掉类的name属性
print(Student.name) # 但是类属性并未消失，用Student.name仍然可以访问
del s.name # 如果删除实例的name属性
print(s.name) # 再次调用s.name，由于实例的name属性没有找到，类的name属性就显示出来了
'''
从上面的例子可以看出，在编写程序的时候，千万不要把实例属性和类属性使用相同的名字，
因为相同名称的实例属性将屏蔽掉类属性，但是当你删除实例属性后，再使用相同的名称，访问到的将是类属性
'''

