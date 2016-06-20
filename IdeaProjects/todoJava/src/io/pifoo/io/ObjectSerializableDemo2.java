package io.pifoo.io;

import java.io.*;

/**
 * Created by pifoo on 15/11/18.
 * 序列化中 子类和父类构造函数的调用问题
 */
public class ObjectSerializableDemo2 {
    public static void main(String[] args) throws Exception {
        //对Foo2序列化:递归调用了父类中的构造函数
        /*ObjectOutputStream oos = new ObjectOutputStream(
                new FileOutputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"));
        Foo2 foo2 = new Foo2();
        oos.writeObject(foo2);
        oos.flush();
        oos.close();*/

        //反序列化是否递归调用父类中的构造函数
        /*ObjectInputStream ois = new ObjectInputStream(
                new FileInputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"));
        Foo2 foo2 = (Foo2) ois.readObject();
        System.out.println(foo2);
        ois.close();*/


        //对Bar2序列化
        //序列化显式地创建对象,肯定会总结会调用父类递归方法
        /*ObjectOutputStream oos = new ObjectOutputStream(
                new FileOutputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"));
        Bar2 bar2 = new Bar2();
        oos.writeObject(bar2);
        oos.flush();
        oos.close();*/
        //反序列化,没有实现或继承Serializable的父类构造方法都将被显式调用
        ObjectInputStream ois = new ObjectInputStream(
                new FileInputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"));
        Bar2 bar2 = (Bar2) ois.readObject();
        System.out.println(bar2);
        ois.close();



    }
}

/**
 * 一个类实现了序列化，那么其子类都可以进行序列化
 * 对子类对象进行序列化操作时,其父类的构造函数都会被调用
 * 对子类对象进行反序列化操作时，如果其父类没有实现序列化接口，那么其父类的构造函数会被调用
 *
 */
class Foo implements Serializable{//实现序列化接口
    public Foo(){
        System.out.println("Foo...");
    }
}
class Foo1 extends Foo{
    public Foo1(){
        System.out.println("Foo1...");
    }
}
class Foo2 extends Foo1{
    public Foo2(){
        System.out.println("Foo2...");
    }
}


class Bar{
    public Bar(){
        System.out.println("Bar...");
    }
}
class Bar1 extends Bar implements Serializable{
    public Bar1(){
        System.out.println("Bar1...");
    }
}
class Bar2 extends Bar1{
    public Bar2(){
        System.out.println("Bar2...");
    }
}