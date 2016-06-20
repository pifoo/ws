package io.pifoo.thread.concurrent.raceCondition;

/**
 * Created by pifoo on 15/11/14.
 * 宇宙的能量守恒
 * 遵循能量守恒定律:能量不会凭空产生或消失,只会从一处转移到另一处
 */
public class EnergySystem extends Thread {

    // 能量盒子,用于存储能量
    private final double energyBoxes[];
    // 增加一个私有域(锁)
    private final Object lockObj = new Object();

    /**
     * @param n 能量盒子的数量
     * @param initialEnergy 每个盒子含有的初始参量值
     */
    public EnergySystem(int n, double initialEnergy) {
        energyBoxes = new double[n];
        for (int i = 0; i < energyBoxes.length; i++) {
            energyBoxes[i] = initialEnergy;
        }
    }

    /**
     * 能量转移:从一个盒子转移到另一个盒子
     * @param from 能量源
     * @param to 能量终点
     * @param amount 能量值
     */
    public void transfer(int from, int to, double amount){
        // 互斥
        synchronized (lockObj){
            /*if (energyBoxes[from] < amount) {
                return;
            }*/
            // 使用synchronized后可优化:
            // while循环保证条件不满足时任务都会被条件阻挡,而不是循环竞争CPU资源
            // Wait set(线程休息区)
            while (energyBoxes[from] < amount){
                try {
                    // 条件不满足,将当前线程放入Wait set
                    lockObj.wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            System.out.println(Thread.currentThread().getName());
            energyBoxes[from] -= amount;
            System.out.printf("从%d转移到%10.2f单位能量到%d",from,amount,to);
            energyBoxes[from] += amount;
            System.out.printf("能量总和:%10.2f%n", getToTalEnergies());//能量转移之后能量总值
            //唤醒所有在lockObj对象上等待的线程
            lockObj.notifyAll();
        }

    }

    /**
     * 获取能量世界的能量总和
     */
    public double getToTalEnergies() {
        double sum = 0;
        for (double amount : energyBoxes) {
            sum += amount;
        }
        return sum;
    }

    /**
     * 返回能量盒子的长度
     */
    public double getBoxAmount(){
        return energyBoxes.length;
    }

}
