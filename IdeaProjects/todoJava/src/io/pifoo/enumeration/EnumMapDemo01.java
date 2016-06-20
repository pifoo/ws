package io.pifoo.enumeration;

import javax.swing.*;
import java.util.EnumMap;
import java.util.Map;

/**
 *
 * Created by pifoo on 15/12/25.
 */
enum Color01{
    RED,GREEN,BLUE
}



public class EnumMapDemo01 {
    public static void main(String[] args) {
        Map<Color,String> desc = new EnumMap<Color,String>(Color.class);    //实例化EnumMap
        desc.put(Color.READ,"红色");
        desc.put(Color.GREEN,"绿色");
        desc.put(Color.BLUE,"蓝色");

        System.out.println("输出全部内容:");
        for(Color c : Color.values()){
            System.out.println(c.name() + ": " + desc.get(c));
        }

        System.out.println("输出全部键值:");
        for (Color c : desc.keySet()) {
            System.out.print(c.name() + ",");
        }
        System.out.println("输出全部内容:");
        for (String s : desc.values()) {
            System.out.print(s + ",");
        }

    }
}
