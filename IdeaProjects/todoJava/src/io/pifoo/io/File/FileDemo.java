package io.pifoo.io.File;

import java.io.File;
import java.io.IOException;

/**
 * Created by pifoo on 15/11/16.
 *
 */
public class FileDemo {
    public static void main(String[] args) {

        //创建目录
        File file1 = new File("." + File.separator + "out" + File.separator + "file1/1/2");
        if(!file1.exists()){
            //file1.mkdir();
            file1.mkdirs();//创建多级目录
        }else {
            file1.delete();
        }
        System.out.println("file1是否为一个目录: " + file1.isDirectory());
        System.out.println("file1是否为一个文件: " + file1.isFile());
        System.out.println(file1.getPath());

        //创建文件
        //File file2 = new File("." + File.separator + "out" + File.separator + "file2.txt");
        File file2 = new File("." + File.separator + "out" ,"file2.txt");
        if(!file2.exists()){
            try {
                file2.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            file2.delete();
        }
        System.out.println("file2是否为一个目录: " + file2.isDirectory());
        System.out.println("file2是否为一个文件: " + file2.isFile());

        //常用的File对象的API
        System.out.println(file1);//file1.toString()的内容
        System.out.println(file1.getAbsolutePath());
        System.out.println(file1.getName());
        System.out.println(file2.getName());
        System.out.println(file1.getParent());
        System.out.println(file1.getParentFile().getAbsolutePath());

    }
}
