package io.pifoo.io.inputStream;

import java.io.*;

/**
 * Created by pifoo on 15/11/17.
 */
public class IOUtil {
    /**
     * 读取指定文件内容,按照16进制输出到控制台
     * 并且每输出10个byte换行
     * @param fileName
     * 单字节读取不适合大文件 ,效率很低
     */
    public static void printHex(String fileName) throws IOException{
        //把文件作为字节流进行读操作
        FileInputStream in = new FileInputStream(fileName);
        int b;
        int i = 1;
        while ((b = in.read()) != -1){
            if(b <= 0xf){
                //单位数前面补0,以两位形式输出
                System.out.print("0");
            }
            System.out.print(Integer.toHexString(b) + "  ");
            if (i++%10 == 0) {
                System.out.println();
            }
        }
        in.close();
        System.out.println();
    }

    /**
     * 批量字节读取,大文件效率高,也是常用的读文件方式
     * @param fileName
     * @throws IOException
     */
    public static void printHexByByteArray(String fileName) throws IOException{
        FileInputStream in = new FileInputStream(fileName);
        byte[] buf = new byte[20 * 1024];
        //从in中批量读取字节,放入到buf这个字节数组中
        // 从第0个位置开始放,最多放buf.length个
        // 返回的是读到的字节的个数
        /*
        int bytes = in.read(buf,0,buf.length);//一次性读完,说明字节数组足够大
        int j = 1;
        for (int i = 0; i < bytes; i++) {
            if(buf[i] < 0xf){
                System.out.print("0");
            }
            System.out.print(Integer.toHexString(buf[i]) + "  ");
            if(j++%10 == 00){
                System.out.println();
            }
        }
        in.close();
        System.out.println();如下代码实现同样功能*/

        int bytes = 0;
        int j = 1;
        while ((bytes = in.read(buf,0,buf.length)) != -1){
            for (int i = 0; i < bytes; i++) {
                System.out.print(Integer.toHexString(buf[i] & 0xff) + "  ");
                if (j++%10 == 0) {
                    System.out.println();
                }
            }
        }
        in.close();
        /**
         * & 0xff
         * byte类型8位, int类型32位
         * 为了避免数据转换错误, 通过 & 0xff 将高于24位清零
         */
    }

    /**
     * 拷贝文件 ,字节批量读取 ,   快!!!
     * @param srcFile
     * @param destFile
     * @throws IOException
     */
    public static void copyFile(File srcFile,File destFile) throws IOException{
        if(!srcFile.exists()){
            throw new IllegalArgumentException("文件 "+ srcFile +" 不存在!");
        }
        if(!srcFile.isFile()){
            throw new IllegalArgumentException(srcFile +"不是文件!");
        }
        //读操作
        FileInputStream in = new FileInputStream(srcFile);
        //写操作
        FileOutputStream out = new FileOutputStream(destFile);
        //批量读写
        byte[] buf = new byte[8*1024];
        int b;
        while ((b = in.read(buf,0,buf.length)) != -1){
            out.write(buf,0,b);
            out.flush();//最好加上
        }
        in.close();
        out.close();
    }

    /**
     * 利用带缓冲的字节流拷贝文件  一般!!!
     * @param srcFile 目标文件
     * @param destFile 源文件
     * @throws IOException
     */
    public static void copyFileByBuffer(File srcFile,File destFile) throws IOException{
        if(!srcFile.exists()){
            throw new IllegalArgumentException("文件 "+ srcFile +" 不存在!");
        }
        if(!srcFile.isFile()){
            throw new IllegalArgumentException(srcFile +"不是文件!");
        }

        //读操作
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(srcFile));
        //写操作
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(destFile));

        int c;
        while ((c = bis.read()) != -1){
            bos.write(c);
            bos.flush();//刷新缓冲区
        }
        bis.close();
        bos.close();
    }

    /**
     * 单字节不带缓冲copy文件  慢!!!
     * @param srcFile
     * @param destFile
     * @throws IOException
     */
    public static void copyFileByByte(File srcFile,File destFile) throws IOException{
        if(!srcFile.exists()){
            throw new IllegalArgumentException("文件 "+ srcFile +" 不存在!");
        }
        if(!srcFile.isFile()){
            throw new IllegalArgumentException(srcFile +"不是文件!");
        }

        //读操作
        FileInputStream fis = new FileInputStream(srcFile);
        //写操作
        FileOutputStream fos = new FileOutputStream(destFile);

        int c;
        while ((c = fis.read()) != -1){
            fos.write(c);
            fos.flush();//刷新缓冲区
        }
        fis.close();
        fos.close();
    }


}
