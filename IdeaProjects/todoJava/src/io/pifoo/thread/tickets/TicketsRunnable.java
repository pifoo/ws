package io.pifoo.thread.tickets;

/**
 * Created by pifoo on 15/11/15.
 */
class MyThreads implements Runnable{
    private int ticketsCont = 5;//有5张票

    @Override
    public void run() {
        while (ticketsCont > 0){
            ticketsCont--;//如果还有票就卖掉一张
            System.out.println(Thread.currentThread().getName() + " 卖了一张票,余票为: " + ticketsCont  );
        }
    }
}

public class TicketsRunnable  {
    public static void main(String[] args) {
        MyThreads mt = new MyThreads();
        /*MyThreads mt1 = new MyThreads();
        MyThreads mt2 = new MyThreads();
        MyThreads mt3 = new MyThreads();*/


        Thread th1 = new Thread(mt,"窗口1");
        Thread th2 = new Thread(mt,"窗口2");
        Thread th3 = new Thread(mt,"窗口3");

        th1.start();
        th2.start();
        th3.start();
    }


}
