package io.pifoo.classSet;

import java.util.*;

/*
 * TreeSet 实现了 SortedSet 接口 ,此接口主要用于排序操作
 * Created by pifoo on 15/12/24.
 */
public class TreeSetDemo01 {
    public static void main(String[] args) {
        SortedSet<String> allSet = new TreeSet<String>();  // 为 SortedSet 实例化
        allSet.add("A");
        allSet.add("B");
        allSet.add("_");
        allSet.add("B");        // 不能添加
        allSet.add("C");
        allSet.add("D");
        allSet.add("E");
        allSet.add("F");
        System.out.println(allSet);
        System.out.println("第一个元素: " + allSet.first());
        System.out.println("最后一个元素: " + allSet.last());
        System.out.println("返回从开始到指定元素的集合: " + allSet.headSet("C")); // 不包含指定元素
        System.out.println("返回从指定元素到最后元素的集合: " + allSet.tailSet("B"));
        System.out.println("返回指定对象间元素的集合: " + allSet.subSet("B","D")); //

        System.out.println();

        // 集合输出

        // 1. 迭代输出:Iterator接口 (常用标准操作形式)
        Iterator<String> iter = allSet.iterator();   // 直接实例化Iterator接口

        // 1.1 迭代输出,删除指定 Collection  内容
        System.out.print("实例化 Iterator 输出集合: ");
        while (iter.hasNext()){     // 依次判断
            String str = iter.next(); // 取出内容
            if("_".equals(str)){
                iter.remove();      // 删除当前元素 _
                //allSet.remove(str);    // 使用集合删除, 会破坏集合的内容
            }else {
                System.out.print(str + ",");
            }
        }
        System.out.println("\n" + allSet);

        // 1.2 使用 ListIterator 双向迭代输出(双向输出只有List接口支持)
        // 后向输出必先前向输出
        List<String> allList = new ArrayList<String>();
        allList.add("A");
        allList.add("B");
        allList.add("_");
        allList.add("B");        // 不能添加
        allList.add("C");
        ListIterator<String> listIterator = allList.listIterator(); // 实例化 ListIterator 接口
        System.out.print("前向输出: ");
        while (listIterator.hasNext()){
            System.out.print(listIterator.next() + ",");
        }
        System.out.print("\n前向输出: ");
        while (listIterator.hasPrevious()){
            System.out.print(listIterator.previous() + ",");
        }

        System.out.print("\nforeach输出集合: " );
        for (String str : allList) {
            System.out.print(str + ",");
        }




    }
}
