package io.pifoo.io;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 * Created by pifoo on 15/11/18.
 * 对象的序列化、反序列化
 */
public class ObjectSerializableDemo {
    public static void main(String[] args) throws Exception {
        String file = "/Users/pifoo/IdeaProjects/todoJava/out/test.txt";
        // 1. 对象序列化
        /*ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file));
        Student stu = new Student("1001","pifoo",23);
        oos.writeObject(stu);
        oos.flush();
        oos.close();*/
        // 2. 反序列化
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));
        Student stu = (Student) ois.readObject();
        System.out.println(stu);
    }


}

