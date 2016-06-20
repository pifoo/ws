package io.pifoo.thread.tickets;

/**
 * Created by pifoo on 15/11/15.
 */
class MyThread extends Thread{
    private int ticketsCont = 5;//有5张票
    private String name;//窗口,即线程的name

    public MyThread(String name) {
        this.name = name;
    }

    @Override
    public void run() {
        while (ticketsCont > 0){
            ticketsCont--;//如果还有票就卖掉一张
            System.out.println(getName() + "卖了一张票,余票为: " + ticketsCont  );
        }
    }
}

public class TicketsThread {
    public static void main(String[] args) {
        //创建三个线程,模拟三个窗口卖票
        MyThread mt1 = new MyThread("窗口1");
        MyThread mt2 = new MyThread("窗口2");
        MyThread mt3 = new MyThread("窗口3");

        //启动线程,开始卖票
        mt1.start();
        mt2.start();
        mt3.start();

    }
}
