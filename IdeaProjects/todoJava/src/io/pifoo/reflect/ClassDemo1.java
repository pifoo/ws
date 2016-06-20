package io.pifoo.reflect;

/**
 * Created by pifoo on 15/11/19.
 * 认识Class
 */
public class ClassDemo1 {
    public static void main(String[] args) throws IllegalAccessException, InstantiationException {
        //Foo的实例对象如何表示
        Foo foo = new Foo();
        //Foo这个类也是一个实例对象,Class类的实例对象,如何表示
        //任何一个类都是class类的实例对象,这个实例对象有三种表示方式

        //1,任何一个类都有一个隐含的静态成员变量class
        Class c1 = Foo.class;

        //2,已知该类的对象,通过getClass()方法;
        Class c2 = foo.getClass();

        /**
         * 官网说法:c1,c2表示了Foo类的类类型(class type)
         * 万事万物皆对象,类也是对象,是Class类的实例对象
         * 这个对象我们称之为该类的类类型
         */
        //不管c1 or c2 都代表了Foo类的类类型,一个类只可能是Class类的一个实例对象
        System.out.println(c1 == c2);

        //3,
        Class c3 = null;
        try {
            c3 = Class.forName("io.pifoo.reflect.Foo");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        System.out.println(c2 == c3);

        //通过类的类类型创建该类的对象实例->通过 c1 or c2 or c3创建Foo的实例
        Foo foo1 = (Foo)c1.newInstance();
        foo1.print();



    }
}
class Foo{
    void print(){
        System.out.println("foo");
    }
}