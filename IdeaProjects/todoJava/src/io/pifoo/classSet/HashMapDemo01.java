package io.pifoo.classSet;

import java.util.*;

/**
 *
 * Created by pifoo on 15/12/25.
 */
public class HashMapDemo01 {
    public static void main(String[] args) {

        //Map<String,String> map = new HashMap<String,String>();  // 通过子类实例化 Map; 无序
        Map<String,String> map = new TreeMap<>();  // 通过子类实例化 Map; 有序

        map.put("a","A");
        map.put("y","Y");
        map.put("e","E");
        map.put("b","B");
        map.put("c","C");
        String val = map.get("a");              // 根据key 取出value
        System.out.println("a: " + val);

        if(map.containsKey("a")){
            System.out.println("搜索的key 'a' 存在");
        }
        if(map.containsValue("A")){
            System.out.println("搜索的value 'A' 存在");
        }

        // 得到全部的 key,value 变为一个Set集合
        Set<String> keys = map.keySet();
        Collection<String> values = map.values();       // 此方法返回的类型为 Collection

        Iterator<String> iterKey = keys.iterator();    // 实例化 Iterator
        Iterator<String> iterVal = values.iterator();    // 实例化 Iterator

        System.out.print("全部的Key: ");
        while (iterKey.hasNext()){
            System.out.print(iterKey.next() + ",");
        }

        System.out.print("\n全部的value: ");
        while (iterVal.hasNext()){
            System.out.print(iterVal.next() + ",");
        }

        System.out.println("\n使用 Iterator 输出 Map");
        //使用 Iterator 输出 Map 实例(不能直接迭代输出,必先将 Map 接口实例变为 Set 接口实例)
        Set<Map.Entry<String,String>> mapToSet = map.entrySet();
        Iterator<Map.Entry<String,String>> iterator = mapToSet.iterator();
        while (iterator.hasNext()){
            Map.Entry<String,String> me = iterator.next();  // 找到 Map.Entry 实例
            System.out.println(me.getKey() + ":" + me.getValue());
        }
        for (Map.Entry<String,String> me : map.entrySet()) {
            System.out.println(me.getKey() + ":" + me.getValue());
        }

    }
}
