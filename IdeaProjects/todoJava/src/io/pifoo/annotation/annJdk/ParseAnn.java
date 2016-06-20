package io.pifoo.annotation.annJdk;

import io.pifoo.annotation.Description;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

/**
 * Created by pifoo on 15/11/20.
 * 解析注解
 */
//TODO
public class ParseAnn {
    public static void main(String[] args) throws Exception {
        //1. 使用类加载器加载类
        Class c = Class.forName("io.pifoo.annotation.annJdk.Child");
        //2. 找到类上面的注解
        Boolean isExist = c.isAnnotationPresent(Description.class);
        if(isExist){
            //3. 拿到注解实例
            Description d = (Description) c.getAnnotation(Description.class);
            System.out.println(d.value());
        }
        //4. 找到方法上的注解
        Method[] ms = c.getMethods();
        for (Method m:ms) {
            Boolean isMExist = m.isAnnotationPresent(Description.class);
            if(isMExist){
                Description d = (Description) m.getAnnotation(Description.class);
                System.out.println(d.value());
            }
        }

        // 另外一种解析方法
        for(Method m:ms){
            Annotation[] as = c.getAnnotations();
            for (Annotation a:as) {
                if (a instanceof Description){
                    Description d = (Description) a;
                    System.out.println(d.value());
                }
            }
        }
    }
}
