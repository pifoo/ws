package io.pifoo.enumeration;

/**
 *
 * Created by pifoo on 15/12/25.
 */
enum Color{             // 定义枚举类型
    READ,GREEN,BLUE     // 定义枚举对象
}
public class EnumDemo01 {
    public static void main(String[] args) {
        Color c = Color.READ;
        System.out.println(c);

        for (Color e : Color.values()) {
            System.out.print(e + ": ");
            print(e);

            System.out.println(c.ordinal() + " > " + c.name());

        }


    }
    // 使用switch输出
    private static void print(Color e) {
        switch (e){
            case READ:
                System.out.println("红色");
                break;
            case GREEN:
                System.out.println("绿色");
                break;
            case BLUE:
                System.out.println("蓝色");
                break;
            default:{
                System.out.println("颜色未知");
                break;
            }
        }
    }


}
