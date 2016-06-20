package io.pifoo.oop.DesignPatterns;

import java.util.Observable;
import java.util.Observer;

/**
 * 观察者模式<发布订阅模式>:(Observable类,,Observer接口)
 * 应用场景:购房者<被观察者/目标对象>(  观察者<订阅者>)关注房价
 *
 * pifoo on 15/12/17.
 */

class House extends Observable{                                        // 被观察者类
    private float price;

    public House(float price) {
        this.price = price;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        super.setChanged();                                             // 设置变化点(被观察者状态发生变化)
        super.notifyObservers(price);                                   // 通知所有观察者价格变化

        this.price = price;
    }

    @Override
    public String toString() {
        return "House{" +
                "price=" + this.price +
                '}';
    }
}

class HousePriceObserver implements Observer{                           // 观察者类
    private String name;

    public HousePriceObserver(String name) {
        this.name = name;
    }

    @Override
    public void update(Observable o, Object arg) {    //参数1:表示被观察者实例; 参数2:表示修改的内容
        if (arg instanceof Float) {                                     // 判断参数类型
            System.out.print(this.name + "观察到价格更改为: ");
            System.out.println(((Float) arg).floatValue());
        }
    }
}

public class ObserverPattern {
    public static void main(String[] args) {
        //  1. 创建目标
        House h = new House(10000);

        //  2. 创建观察者
        HousePriceObserver hpo1 = new HousePriceObserver("购房者 A ");
        HousePriceObserver hpo2 = new HousePriceObserver("购房者 B ");
        HousePriceObserver hpo3 = new HousePriceObserver("购房者 C ");

        //  3. 注册观察者
        h.addObserver(hpo1);
        h.addObserver(hpo2);
        h.addObserver(hpo3);

        //  4. 发布信息
        System.out.println(h);      // 输出房子价格
        h.setPrice(6666);
        System.out.println(h);
    }
}
