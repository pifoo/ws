package io.pifoo.thread.base;

/**
 * Created by pifoo on 15/11/14.
 */
//TODO
public class WrongWayStopThread extends Thread {
    public static void main(String args[]){

        WrongWayStopThread thread = new WrongWayStopThread();

        System.out.println("Starting thread....");
        thread.start();
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Interrupting thread....");
        Thread.interrupted(); //中断线程(其实并没中断运行)
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Stopping application....");

    }

    @Override
    public void run() {
        //while (true){
        while (!this.isInterrupted()){//Interrupted可以让状态发生一些改变
            System.out.println("Thread is running....");
            long time = System.currentTimeMillis();
            while (System.currentTimeMillis() - time < 1000){
                //减少屏幕输出的循环,每秒输出一次,相当于sleep(1000)
            }
            /*try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }*/
        }
    }
}
