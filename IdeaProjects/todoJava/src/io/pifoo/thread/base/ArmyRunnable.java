package io.pifoo.thread.base;

/**
 * Created by pifoo on 15/11/14.
 */
//作战线程
//模拟作战作战双方的行为
public class ArmyRunnable implements Runnable {
    //volatile保证了线程可以读取其它线程写入的值
    //可见性 ref JMM, happens-before原则
    //TODO volatile
    volatile boolean  keepRunning = true;

    @Override
    public void run() {
        while (keepRunning){
            //发动5连攻击
            for (int i = 0; i < 5; i++) {
                System.out.println(Thread.currentThread().getName() + "进攻对方[ " + i + " ]");
                //让出处理器时间,下次谁进攻还不一定呢
                Thread.yield();
            }
        }
        System.out.println(Thread.currentThread().getName() + "结束了战斗");
    }
}
