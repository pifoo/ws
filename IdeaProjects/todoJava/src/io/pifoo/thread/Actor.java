package io.pifoo.thread;

/**
 * Created by pifoo on 15/11/14.
 * http://www.imooc.com/video/4241
 */
public class Actor extends Thread {
    /**
     * 1,继承Thread类
     * 2,覆写run()
     * 3,启动Thread对象
     */
    @Override
    public void run() {
        System.out.println(getName() + " 是一个演员!");//获取当前线程的名称
        int count = 0;
        boolean keepRunning = true;
        while (keepRunning) {
            System.out.println(getName() + " 登台演出: " + (++count) + " 次.");
            if(count == 100){
                keepRunning = false;
            }
            if(count % 10 == 0 ){
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println(getName() + " 的演出结束了.");//获取当前线程的名称
    }

    public static void main(String args[]){
        Thread actor = new Actor();
        actor.setName("Mr.Thread");
        actor.start();

        Thread actreesThread = new Thread(new Actrees(),"Miss.Runnable");
        actreesThread.start();

    }
}

class Actrees implements Runnable {
    /**
     * 1,实现Runnable接口
     * 2,覆写run()
     */
    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName() + " 是一个演员!");//获取当前线程的名称
        int count = 0;
        boolean keepRunning = true;
        while (keepRunning) {
            System.out.println(Thread.currentThread().getName() + " 登台演出: " + (++count) + " 次.");
            if(count == 100){
                keepRunning = false;
            }
            if(count % 10 == 0 ){
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println(Thread.currentThread().getName() + " 的演出结束了.");//获取当前线程的名称
    }

}