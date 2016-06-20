package io.pifoo.classSet;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 * Vector  使用同步处理方式,属于非线程安全的操作类
 * 可以使用 Iterator,foreach,Enumeration 输出
 * Created by pifoo on 15/12/23.
 */
public class VectorDemo01 {
    public static void main(String[] args) {
        List<String> allList = new Vector<String>();
        allList.add("world");
        allList.add(0,"hello");
        allList.add("pifoo");
        allList.add("30");
        System.out.println(allList);

    }
}
