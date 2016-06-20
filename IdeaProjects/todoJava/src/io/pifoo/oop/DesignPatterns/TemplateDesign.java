package io.pifoo.oop.DesignPatterns;

/**
 * 模板模式 (抽象类的实际应用)
 * Person类相当于定义了一个模板,在主方法中调用时,调用的就是普通方法,而子类只需要实现父类中的抽象方法,就可以取得一个具体信息;
 * Created by pifoo on 15/12/15.
 */

abstract class Person{
    private String name;
    private int age;

    public Person(int age, String name) {
        this.age = age;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void say(){                                      // 说话是具体功能, 要定义成普通方法
        System.out.println(this.getContent());
    }

    public abstract String getContent();                    // 说话的内容由子类决定
}

class Student extends Person{
    private float score;

    public Student(String name, int age, float score) {
        super(age, name);                                   // 调用父类的构造方法
        this.score = score;
    }

    @Override
    public String getContent() {
        return "学生信息->姓名:" + super.getName() +
                ";年龄:" + super.getAge() +
                ";成绩:" + this.score;
    }
}

class Worker extends Person{
    private float score;

    public Worker(String name, int age, float salary) {
        super(age, name);                                   // 调用父类的构造方法
        this.score = salary;
    }

    @Override
    public String getContent() {
        return "工人信息->姓名:" + super.getName() +
                ";年龄:" + super.getAge() +
                ";工资:" + this.score;
    }
}

public class TemplateDesign {
    public static void main(String[] args) {
        Person per1 = null;
        Person per2 = null;
        per1 = new Student("张三", 20, 90.0f);
        per2 = new Worker("李四", 45, 4500.0f);

        per1.say();
        per2.say();
    }
}