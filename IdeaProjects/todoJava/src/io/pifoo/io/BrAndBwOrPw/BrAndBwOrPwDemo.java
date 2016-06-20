package io.pifoo.io.BrAndBwOrPw;

import java.io.*;

/**
 * Created by pifoo on 15/11/18.
 * 字符流的过滤器
 - BufferedReader -> readLine 一次读一行
 - BufferedWriter/PrintWriter-> 写一行
 */
public class BrAndBwOrPwDemo {
    public static void main(String[] args) throws IOException {
        //对文件进行读写操作
        BufferedReader br = new BufferedReader(
                new InputStreamReader(
                        new FileInputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt")));
        /*BufferedWriter bw = new BufferedWriter(
                new OutputStreamWriter(
                        new FileOutputStream("/Users/pifoo/IdeaProjects/todoJava/out/test1.txt")));*/
        PrintWriter pw = new PrintWriter("/Users/pifoo/IdeaProjects/todoJava/out/test1.txt");
        String line;
        while ((line=br.readLine()) != null){//一次读一行,并不能识别换行
            System.out.println(line);
            /*bw.write(line);
            //单独进行换行操作
            bw.newLine();
            bw.flush();*/
            pw.println(line);
            pw.flush();
        }
        br.close();
        /*bw.close();*/
        pw.close();



    }
}
