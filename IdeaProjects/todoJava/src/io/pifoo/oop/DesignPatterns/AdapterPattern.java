package io.pifoo.oop.DesignPatterns;

/**
 * 问题的引出: 实现一个接口,则必须要实现此接口中的全部抽象方法
 * (图形界面编程的事件处理中经常使用 适配器模式)
 *
 * 适配器模式:
 * 一个接口首先被一个抽象类实现(此抽象类通常称为适配器类),并在此抽象类中实现若干方法(方法体为空);
 * 则以后的子类直接继承此抽象类,就可以有选择地覆写所需要的方法
 *
 */

interface Window{                                               // 定义Window接口,表示窗口操作
    void open();
    void close();
    void activated();
    void iconified();
    void deiconified();
}

abstract class WindowAdapter implements Window{   // 定义抽象类实现接口,覆写方法(方法体为空)

    @Override
    public void open() {

    }

    @Override
    public void close() {

    }

    @Override
    public void activated() {

    }

    @Override
    public void iconified() {

    }

    @Override
    public void deiconified() {

    }
}

class WindowImpl extends WindowAdapter{ // 子类直接继承WindowAdapter抽象类,有选择地实现需要的方法
    @Override
    public void open() {
        System.out.println("窗口打开……");
    }

    @Override
    public void close() {
        System.out.println("窗口关闭……");
    }
}

public class AdapterPattern {
    public static void main(String[] args) {
        Window win = new WindowImpl();  // 实现接口对象
        win.open();
        win.close();
    }
}
