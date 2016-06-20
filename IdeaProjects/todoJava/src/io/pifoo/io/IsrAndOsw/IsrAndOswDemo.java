package io.pifoo.io.IsrAndOsw;

import java.io.*;

/**
 * Created by pifoo on 15/11/17.
 * InputStreamReader  完成byte流角析为char流,按照编码解析
 . OutputStreamWriter  提供char流到byte流,按照编码解析
 */
public class IsrAndOswDemo {
    public static void main(String[] args) throws IOException {
        //读数据
        InputStreamReader isr = new InputStreamReader(
                new FileInputStream("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"),"UTF-8");
        //写数据
        OutputStreamWriter osw = new OutputStreamWriter(
                new FileOutputStream("/Users/pifoo/IdeaProjects/todoJava/out/test1.txt"),"UTF-8");

        /*int c;
        while ((c=isr.read()) != -1){
            System.out.print((char)c);
        }*/

        char[] buffer = new char[1*1024];//开辟空间
        int c;
        //批量读取,放入buffer这个字符数组,从第0个位置存放,最多放buffer.length
        //返回的是读取的字符个数
        while ((c=isr.read(buffer,0,buffer.length)) != -1){
            System.out.println(new String(buffer,0,c));//构造成字符串
            osw.write(buffer,0,c);
            osw.flush();
        }
        isr.close();
        osw.close();



    }
}
