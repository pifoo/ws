package io.pifoo.thread.base;

/**
 * Created by pifoo on 15/11/14.
 */
//大戏舞台
public class Stage extends Thread {
    @Override
    public void run() {
        System.out.println("欢迎观看隋唐演义!");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("大幕徐徐拉开……");

        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("话说隋朝末年,随军与起义军杀的昏天暗地……");

        ArmyRunnable armyTaskOfSuiDynasty = new ArmyRunnable();//隋军作战线程
        ArmyRunnable armyTaskOfRevolt = new ArmyRunnable();//起义军作战线程

        //使用Runnable接口创建线程
        Thread armyOfSuiDynasty = new Thread(armyTaskOfSuiDynasty,"隋军");
        Thread armyOfRevolt = new Thread(armyTaskOfRevolt,"起义军");

        //启动线程,开始作战
        armyOfSuiDynasty.start();
        armyOfRevolt.start();

        //舞台线程休眠,大家专心观看军队厮杀
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("正当双方激战正酣,半路杀出了程咬金");

        Thread mrCheng = new KeyPersonThread();
        mrCheng.setName("Mr.Cheng");

        System.out.println("程咬金的理想就是结束战争,使百姓安居乐业.");

        //军队休战,停止线程的方法
        armyTaskOfSuiDynasty.keepRunning = false;
        armyTaskOfRevolt.keepRunning = false;
        //演示,不正确的停止线程
        /*armyOfSuiDynasty.stop();
        armyOfRevolt.stop();*/

        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        //历史舞台留给关键人物
        mrCheng.start();

        //万众瞩目,所有线程等待mrCheng完成历史使命
        try {
            mrCheng.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("战争结束,人民安居乐业,程先生实现了积极的人生梦想,为人民作出了贡献");
        System.out.println("谢谢观看隋唐演义,再见!");

        //为了演示
        /*
        armyTaskOfSuiDynasty.keepRunning = false;
        armyTaskOfRevolt.keepRunning = false;

        try {
            armyOfRevolt.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }*/

    }

    public static void main(String args[]){
        new Stage().start();
    }
}
