package io.pifoo.reflect;

import java.lang.reflect.Method;
import java.util.ArrayList;

/**
 * Created by pifoo on 15/11/19.
 * 通过Class,Method来认识泛型的本质
 */
public class MethodDemo2 {
    public static void main(String[] args) throws Exception {
        ArrayList list = new ArrayList();
        ArrayList<String> list1 = new ArrayList<String>();
        list1.add("hello");
        //list1.add(10);//错误的

        Class c1 = list.getClass();
        Class c2 = list1.getClass();
        System.out.println(c1 == c2);

        //反射的操作都是编译之后的操作
        //c1 == c2 结果返回true,说明编译之后集合的泛型是去泛型化的
        //java中集合的泛型,是防止错误输入的,只在编译阶段有限,绕过编译就无效了
        //验证: 我们可以通过方法的反射来操作,绕过编译
        try {
            Method m = c2.getMethod("add", Object.class);
            m.invoke(list1,20);//绕过编译操作,就绕过了泛型
            System.out.println(list1.size());
            System.out.println(list1);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }


    }
}
