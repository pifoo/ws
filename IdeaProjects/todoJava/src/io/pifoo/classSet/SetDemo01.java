package io.pifoo.classSet;

import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

/**
 * Set接口 不能增加重复元素 不能双向输出(无gGet方法)
 * Created by pifoo on 15/12/23.
 */
public class SetDemo01 {
    public static void main(String[] args) {
        /**
         * 散列的存放  元素是无序的
         */
        Set<String> allSet = new HashSet<String>();
        allSet.add("A");
        allSet.add("B");
        allSet.add("B");        // 不能添加
        allSet.add("C");
        System.out.println(allSet);

        // Person类型
        Set<Person> personHashSet = new HashSet<Person>();  // 元素可重复
        personHashSet.add(new Person(10,"X"));
        personHashSet.add(new Person(1,"A"));
        personHashSet.add(new Person(2,"B"));
        personHashSet.add(new Person(5,"B"));
        personHashSet.add(new Person(3,"C"));
        personHashSet.add(new Person(3,"C"));   // 可添加(不同实例)
        personHashSet.add(new Person(19,"Y"));
        personHashSet.add(new Person(3,"C"));
        System.out.println(personHashSet);

        /**
         * 使用 HashSet 并去掉重复元素 / 操作Perso类   覆写equals方法
         */


        /**
         * 有序的存放
         */
        Set<String> treeSet = new TreeSet<String>();
        treeSet.add("Z");
        treeSet.add("Y");
        treeSet.add("X");
        treeSet.add("A");
        treeSet.add("B");
        treeSet.add("B");       // 不能添加
        treeSet.add("C");
        System.out.println(treeSet); // 插入时无序,输出后有序

        /**
         * TreeSet排序说明
         */
        Set<Person> personSet = new TreeSet<Person>();
        personSet.add(new Person(10,"X"));
        personSet.add(new Person(1,"A"));
        personSet.add(new Person(2,"B"));
        personSet.add(new Person(5,"B"));
        personSet.add(new Person(3,"C"));
        personSet.add(new Person(19,"Y"));
        personSet.add(new Person(3,"C"));
        System.out.println(personSet);
    }
}

class Person implements Comparable<Person>{ // 1. 实现 Comparable 接口
    private String name;
    private int age;

    public Person(int age, String name) {
        this.age = age;
        this.name = name;
    }
    //
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {                      // 地址相待 是同一个对象
            return true;
        }
        if(!(obj instanceof Person)){              // 传递的不是本类对象  不是同一对象
            return false;
        }

        Person person = (Person) obj;           // 向下转型
        if (this.name.equals(person.name) && this.age == person.age) {    // 属性依次比较
            return true;
        }else {
            return false;
        }

    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + age;
        return result;
    }

    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }

    @Override
    public int compareTo(Person person) {    // 2. 指定其排序规则
        if (this.age > person.age){
            return 1;
        }else if(this.age < person.age){
            return -1;
        }else {
            //return 0;
            // 增加字符串的比较
            return this.name.compareTo(person.name);
        }
    }
}
