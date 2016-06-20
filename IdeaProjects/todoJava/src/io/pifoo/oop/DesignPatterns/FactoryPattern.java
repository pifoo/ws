package io.pifoo.oop.DesignPatterns;

/**
 * 工厂设计模式:
 * 程序在接口和子类之间加入了一个过滤端,' 通过此过渡端取得接口的实例化对象;
 * 应用场景: 如电脑外设接口(通过子类扩充接口)
 *
 * Created by pifoo on 15/12/14.
 */

interface Fruit{                                                 // 定义一个水果的接口
    public void eat();
}

class Apple implements Fruit{
    @Override
    public void eat() {
        System.out.println("_ _ 吃苹果.");
    }
}

class Orange implements Fruit{
    @Override
    public void eat() {
        System.out.println("_ _ 吃桔子.");
    }
}

// 定义工厂类:接口对象的实例通过工厂取得,这样如果以后再有子类扩充,直接修改工厂类,客户端就可以根据相应标记得到相应实例,
class Factory{
    public static Fruit getInstance(String className){          // 取得接口实例
        Fruit f = null;                                         // 定义接口对象
        if("apple".equals(className)){                          // 判断是哪个子类的标记
            f = new Apple();
        }
        if("orange".equals(className)){
            f = new Orange();
        }

        return f;
    }
}

public class FactoryPattern {
    public static void main(String[] args) {
        Fruit f = null;                                         // 定义接口对象
        f = Factory.getInstance("apple");                       // 通过工厂取得实例
        //f = Factory.getInstance(args[0]);                     // 命令行运行: java FactoryPattern apple or orange
        if(f != null) {
            f.eat();
        }
    }
}


