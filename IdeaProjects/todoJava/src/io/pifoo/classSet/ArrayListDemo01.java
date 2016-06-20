package io.pifoo.classSet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * List 接口请允许元素重复
 * ArrayList
 * 使用异步处理方式,性能高, 属于线程安全的操作类
 * 只能使用 Iterator,foreach 输出
 * Created by pifoo on 15/12/23.
 */
public class ArrayListDemo01 {
    public static void main(String[] args) {
        // 利用多态特性实例化对象
        List<String> allList = new ArrayList<String>();        // 实例化List对象,只能是String类型
        Collection<String> allCollection = new ArrayList<String>();        // 实例化Collection对象,只能是String类型

        /**
         * 1. 添加元素
         */

        allList.add("Hello");                           // 从Collection继承的方法
        allList.add(0,"world");                         // 此方法为List扩充的方法
        System.out.println(allList);                    // 输出集合中的内容

        allCollection.add("pifoo");
        allCollection.add("30");
        System.out.println(allCollection);

        allList.addAll(allCollection);                  // 从Collection继承的方法,增加一组对象
        allList.addAll(0,allCollection);                // 此方法是List自定义的
        System.out.println(allList);

        allCollection.addAll(allList);
        System.out.println(allCollection);

        /**
         * 2. 删除元素
         */

        allList.remove(0);        //删除指定位置的元素
        allList.remove("Hello");  //删除指定内容的元素
        System.out.println("allList: " + allList);

        /**
         * 3. 输出List中的内容
         */
        System.out.print("由前向后输出: ");
        for (int i = 0; i < allList.size(); i++) { // Collection接口中定义的方法,取得集合中数据长度
            System.out.print(allList.get(i) + ",");    // List接口中定义的方法,取得集合中指定位置的元素
        }
        System.out.print("\n");

        System.out.print("由后向前输出: ");
        for (int i = allList.size() - 1; i >= 0 ;i--) {
            System.out.print(allList.get(i) + ",");
        }
        System.out.print("\n");

        /**
         * 4. 将集合变为对象数组
         */
        String str[] = allList.toArray(new String[]{});    // 指定的泛型类型
        System.out.print("指定数组类型: ");
        for (int i = 0; i < str.length; i++) {
            System.out.print(str[i] + ",");                // 输出字符串中数组的内容
        }
        System.out.print("\n返回对象数组: ");
        Object obj[] = allList.toArray();                 // 直接返回对象数组
        for (int i = 0; i < obj.length; i++) {            // 循环输出对象数组内容
            String temp = (String) obj[i];                // 每一个对象都是String类型实例
            System.out.print(temp + ",");
        }

        /**
         * 5. 集合的其它相关操作
         */
        System.out.println("\n集合操作前是否为空: " + allList.isEmpty());
        System.out.println(allList.contains("world") ? "字符串 \"world\" 存在" : "字符串 \"world\" 不存在");
        // 取出里面的部分集合
        List<String> allSub = allList.subList(2,4); // 返回列表中指定的 fromIndex（包括 ）和 toIndex（不包括）之间的部分视图
        System.out.println(allSub);
        System.out.println("world 在集合中的位置: " + allList.indexOf("world"));
        System.out.println("集合操作后是否为空: " + allList.isEmpty());







    }
}
