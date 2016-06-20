package io.pifoo.io.File;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.lang.reflect.Array;
import java.util.Arrays;

/**
 * Created by pifoo on 15/11/16.
 */
public class RandomAccessFileDemo {

    public static void main(String[] args) throws IOException{
        //创建目录
        File demo = new File("dmeo");
        if(!demo.exists()){
            demo.mkdir();
        }
        //创建文件
        File file = new File(demo,"raf.dat");
        if(!file.exists()){
            file.createNewFile();
        }
        //操作文件内容
        RandomAccessFile raf = new RandomAccessFile(file,"rw");
        //指针的位置
        System.out.println("初始指针位置: " + raf.getFilePointer());
        raf.write('A');//只写了一个字节
        System.out.println("写入 A 后指针的位置: " + raf.getFilePointer());
        raf.write('B');
        System.out.println("写入 B 后指针的位置: " + raf.getFilePointer());

        int i = 0x7fffffff;
        //用write()每次只能写一个字节,如果要把i写进去就得写4次
        raf.write(i >>> 24); //高8位,右移24
        raf.write(i >>> 16);
        raf.write(i >>> 8);
        raf.write(i);
        System.out.println("写入 i 后指针的位置: " + raf.getFilePointer());

        //可以直接写一个Int
        raf.writeInt(i);

        String s = "中";
        byte[] gbk = s.getBytes("gbk");
        raf.write(gbk);

        System.out.println("文件的长度: " + raf.length());
        System.out.println("写入 '中' 后指针的位置: " + raf.getFilePointer());



        //读文件,必须把指针移到头部
        raf.seek(0);
        //一次性读取,把文件中的内容都读到字节数组中
        byte[] buf = new byte[(int) raf.length()];
        raf.read(buf);
        System.out.println(Arrays.toString(buf));
        //构造成字符串
        String s1 = new String(buf,"gbk");
        System.out.println(s1);
        //以十六进制输出
        for (byte b:buf) {
            System.out.println(Integer.toHexString(b & 0xff));
        }

        raf.close();
    }
}
