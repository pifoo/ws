package io.pifoo.classSet;

import java.util.LinkedList;

/**
 * 在链表的开头和结尾增加数据
 * Created by pifoo on 15/12/23.
 */
public class LinkedListDemo01 {
    public static void main(String[] args) {
        /**
         * 为链表增加数据
         */
        LinkedList<String> link = new LinkedList<String>();
        link.add("B");
        link.add("C");
        link.add("D");
        System.out.println("初始化链表: " + link);
        link.addFirst("A");
        link.addLast("Z");
        System.out.println("增加头,尾后的链表: " + link);

        System.out.println("1-1, element()方法找到表头: " + link.element());
        System.out.println("1-2, 找完之后的链表内容: : " + link);

        System.out.println("2-1, peek()方法找到表头: " + link.peek());    //找到不删除表头
        System.out.println("2-2, 找完之后的链表内容: : " + link);

        System.out.println("3-1, poll()方法找到表头: " + link.poll());    //找到并删除表头
        System.out.println("3-2, 找完之后的链表内容: : " + link);

        /**
         * 以先进先出的方式取出全部的数据
         */
        System.out.print("以FIFO的方式输出: ");
        for (int i = 0; i < link.size() + 1; i++) {
            System.out.print(link.poll() + ",");    // 循环取出表头
        }

    }
}
