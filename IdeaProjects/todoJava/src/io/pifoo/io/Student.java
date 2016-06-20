package io.pifoo.io;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by pifoo on 15/11/18.
 * 对象的序列化、反序列化
 */
public class Student implements Serializable{//必须实现序列化接口
    private String stuNo;
    private String stuName;
    private transient int stuAge;//transient关键字修饰的内容 jvm 默认不被序列化
    //ArrayList类中的writeObject进行签名,自己完成序列化
    public Student() {
    }

    public Student(String stuNo, String stuName, int stuAge) {
        super();
        this.stuNo = stuNo;
        this.stuName = stuName;
        this.stuAge = stuAge;
    }

    public void setStuNo(String stuNo) {
        this.stuNo = stuNo;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public void setStuAge(int stuAge) {
        this.stuAge = stuAge;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuNo='" + stuNo + '\'' +
                ", stuName='" + stuName + '\'' +
                ", stuAge=" + stuAge +
                '}';
    }
    //方法签名
    //自定义序列化
    private void writeObject(java.io.ObjectOutputStream s) throws java.io.IOException {
        s.defaultWriteObject();//把jvm能默认序列化的元素进行序列化操作
        s.writeInt(stuAge);//自己完成stuAge元素的序列化
    }
    //反序列化
    private void readObject(java.io.ObjectInputStream s)
            throws java.io.IOException, ClassNotFoundException {
        s.defaultReadObject();//把jvm默认反序列化的元素进行反序列化操作
        this.stuAge = s.readInt();//自己完成stuAge元素的反序列化操作
    }
}
