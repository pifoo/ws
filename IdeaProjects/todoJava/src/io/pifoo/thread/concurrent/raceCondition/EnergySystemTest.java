package io.pifoo.thread.concurrent.raceCondition;

/**
 * Created by pifoo on 15/11/14.
 * http://www.imooc.com/video/4889
 */
public class EnergySystemTest {
    //将要构建的能量世界中能量盒子的数量
    public static final int BOX_AMOUNT = 10;
    //每个盒子初始能量
    public static final double INITIAL_ENERGY = 100;

    public static void main(String[] args) {
        EnergySystem eng = new EnergySystem(BOX_AMOUNT, INITIAL_ENERGY);
        for (int i = 0; i < BOX_AMOUNT; i++) {
            EnergyTransferTask task = new EnergyTransferTask(eng, i, INITIAL_ENERGY);
            Thread t = new Thread(task,"TransFerThread_" + i);
            t.start();
        }
    }

}
