package io.pifoo.reflect;

import java.lang.reflect.Method;

/**
 * Created by pifoo on 15/11/19.
 */
public class MethodDemo1 {
    public static void main(String[] args) {
        /**
         * 要获取print(int,int)方法
         * 1.要获取一个方法就是获取类的信息,获取类的信息首先要获取类的类类型
         */
        A a1 = new A();
        Class c = a1.getClass();
        /**
         * 2. 获取方法 名称和参数列表来决定
         * getMethod获取的是public的方法
         * getDeclaredMethod获得的是自己声明的方法
         */
        //c.getDeclaredMethods();
        try {
            //Method m = c.getMethod("print",new Class[]{int.class,int.class});
            Method m = c.getMethod("print",int.class,int.class);//获取方法对象,将来对方法进行反射操作

            //方法的反射操作
            //a1.print(10,20);正常使用方式
            //方法的反射操作是用 m 对象来进行方法调用,和a1.print(10,20)效果完全相同
            //方法如果没有返回值则返回null,有返回值则返回具体的值
            //Object o = m.invoke(a1,new Object[]{10,20});
            Object o = m.invoke(a1,10,20);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}

class A{
    public void print(int a,int b){
        System.out.println(a + b);
    }
    public void print(String a,String b){
        System.out.println(a.toUpperCase() + "," + b.toLowerCase());
    }
}
