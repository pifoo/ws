package io.pifoo.reflect.DynamicLoadingClass;

/**
 * Created by pifoo on 15/11/19.
 * http://www.imooc.com/video/3733/0
 */

//TODO 编译无法通过
class OfficeBetter {
    public static void main(String[] args){
        //动态加载类,在运行时刻加载
        try {
            //返回的是加载这个类的类类型
            Class c = Class.forName(args[0]);
            //通过类类型创建该类对象
            OfficeAble oa = (OfficeAble) c.newInstance();
            oa.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
