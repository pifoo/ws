package io.pifoo.oop;

/**
 * 制定标准 (接口类的实际应用)
 * 应用场景:USB,外设
 * Created by pifoo on 15/12/15.
 */

// 制定USB标准

interface USB{                                                  // 制定usb接口
    void stard();                                               // 设备开始工作
    void stop();
}

class Computer{
    public static void plugin(USB usb){                          // 只要是USB的设备就都可以插入
        usb.stard();
        System.out.println("usb设备开始工作.");
        usb.stop();
    }
}

class Flash implements USB{

    @Override
    public void stard() {
        System.out.println("U盘开始工作.");
    }

    @Override
    public void stop() {
        System.out.println("U盘停止工作.");
    }
}

class Print implements USB{

    @Override
    public void stard() {
        System.out.println("打印机开始工作.");
    }

    @Override
    public void stop() {
        System.out.println("打印机停止工作.");
    }
}

public class InterfaceCase {
    public static void main(String[] args) {
        Computer.plugin(new Flash());
        Computer.plugin(new Print());
    }
}
