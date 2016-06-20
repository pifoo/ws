package io.pifoo.thread.synchronizedCase;

/**
 * Created by pifoo on 15/11/15.
 */
public class SynchronizedDemo {
    // 共享变量
    private boolean ready = false;
    private int result = 0;
    private int number = 1;

    // 写操作
    public void write() { //可加synchronized关键字修饰
        ready = true;                         //1.1
        number = 2;                             //1.2
    }

    // 读操作
    public void read() {
        if (ready) {
            result = number * 3;
        }
        System.out.println("result的值为:" + result);
    }

    // 内部线程类
    private class ReadWriteThread extends Thread {
        // 根据构造方法中传入的flag参数,确定线程执行读操作还是写操作
        public boolean flag;

        public ReadWriteThread(boolean flag) {
            this.flag = flag;
        }

        @Override
        public void run() {
            if (flag) {
                // 构造方法传入true,执行写操作
                write();
            } else {
                read();
            }
        }

    }


    public static void main(String[] args) {
        SynchronizedDemo synDemo = new SynchronizedDemo();
        synDemo.new ReadWriteThread(true).start();
        try {
            Thread.sleep(1000);//不休眠,可能出现结果为0 (重排序),或加synchronized修饰
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        synDemo.new ReadWriteThread(false).start();
    }
}
