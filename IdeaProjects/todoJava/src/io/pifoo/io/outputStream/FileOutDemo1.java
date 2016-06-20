package io.pifoo.io.outputStream;

import java.io.FileOutputStream;
import java.io.IOException;

import io.pifoo.io.inputStream.IOUtil;

/**
 * Created by pifoo on 15/11/17.
 */
public class FileOutDemo1 {
    /**
     *
     * @param args
     */
    public static void main(String[] args) throws IOException{
        //如果该文件不存在,则直接创建;如存在则删除后创建
        //要追加内容,后面加true参数
        //FileOutputStream会自动创建文件
        FileOutputStream out = new FileOutputStream("/Users/pifoo/IdeaProjects/todoJava/daemon.txt");

        //每次只能写出一个字节
        out.write('A');//写出了A字符的低8位
        out.write('B');//写出了B字符的低8位

        int a = 10;//write只能写8位,那么写一个int需要写4次,每次8位
        out.write(a >>> 24);
        out.write(a >>> 16);
        out.write(a >>> 8);
        out.write(a);

        //write字节数组
        byte[] gbk = "中国".getBytes("gbk");
        out.write(gbk);

        out.close();

        IOUtil.printHex("/Users/pifoo/IdeaProjects/todoJava/daemon.txt");

    }
}
