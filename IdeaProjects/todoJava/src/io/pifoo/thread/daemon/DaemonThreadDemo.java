package io.pifoo.thread.daemon;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Scanner;

/**
 * Created by pifoo on 15/11/15.
 */

class DaemonThread implements Runnable{

    @Override
    public void run() {
        System.out.println("进入守护线程: " + Thread.currentThread().getName());
        try {
            writeToFile();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("退出守护线程: " + Thread.currentThread().getName());
    }

    private void writeToFile() throws Exception {
        File fileName = new File("." + File.separator + "daemon.txt");
        OutputStream os = new FileOutputStream(fileName,true);
        int count = 0;
        while (count < 999){
            os.write(("\r\nword"+ count).getBytes());
            System.out.println("守护线程:" + Thread.currentThread().getName()
                    + "向文件写入了word" + count++);
            Thread.sleep(1000);
        }
    }

}
public class DaemonThreadDemo {
    public static void main(String[] args) {
        System.out.println("程序进入了主线程: " + Thread.currentThread().getName());
        DaemonThread daemonThread = new DaemonThread();
        Thread thread = new Thread(daemonThread);
        thread.setDaemon(true);
        thread.start();

        Scanner scanner = new Scanner(System.in);
        scanner.next();

        System.out.println("程序退出了主线程: " + Thread.currentThread().getName());

    }
}
