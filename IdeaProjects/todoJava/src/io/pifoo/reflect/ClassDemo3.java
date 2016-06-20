package io.pifoo.reflect;

/**
 * Created by pifoo on 15/11/19.
 */
public class ClassDemo3 {
    public static void main(String[] args) {
        String s = "hello";
        ClassUtil.printClassMessage(s);
        ClassUtil.printFieldMessage(s);
        ClassUtil.printConstructorMessage(s);

        Integer n1 = 1;
        //ClassUtil.printClassMessage(n1);
        //ClassUtil.printFieldMessage(n1);




    }
}
