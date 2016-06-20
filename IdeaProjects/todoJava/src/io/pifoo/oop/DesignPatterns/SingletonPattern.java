package io.pifoo.oop.DesignPatterns;

/**
 * 构造方法私有化后,无法实例化对象问题的解决;
 * 此程序的意义:无论声明多少个对象,实际上都只有一个实例, 回收站 便是单例模式的应用;
 *
 * 即 : 单例设计模式(单态)
 *
 * Created by pifoo on 15/12/12.
 */
class Singleton { // 饿汉式
    private static Singleton instance = new Singleton();  //在内部产生本类的 static 实例化对象,将属性封装
    private Singleton(){                                  //此处将构造方法进行封装

    }

    public static Singleton getInstance() {               //通过静态方法取得Singleton类的实例
        return instance;
    }

/*    public static void setInstance(Singleton instance) {
        Singleton.instance = instance;
    }*/

    public void print(){
        System.out.println("构造方法私有化.单例");
    }
}
public class SingletonPattern{
    public static void main(String[] args) {
        // 不合法的构造函数
        // 编译时错误：构造函数 Singleton() 是不可见的
        // Singleton s = new Singleton();

        Singleton s1 = Singleton.getInstance();          // 访问类中的静态方法,取得对象实例
        Singleton s2 = Singleton.getInstance();
        Singleton s3 = Singleton.getInstance();
        s1.print();
        s2.print();
        s3.print();
    }
}

