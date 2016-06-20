package io.pifoo.io;

/**
 * Created by pifoo on 15/11/16.
 */
public class EncodeDemo {
    public static void main(String[] args) throws Exception {

        String s = "慕课ABC";

        System.out.println("----------默认编码 UTF-8----------");
        //UTF-8编码中文占用三个字节,英文占用一个字节
        byte[] bytes1 = s.getBytes();//把字条串转换成字节,采用的项目默认编码UTF-8
        for (byte b:bytes1) {
            //以字节形式输出
            System.out.print(b + ",");
            //把字节(转换成了Int)以十六进制形式输出,& 0xff把前面的0去掉,只留下后8位
            System.out.println(Integer.toHexString(b & 0xff));
        }

        System.out.println("----------GBK编码----------");
        //gbk编码中文占用两个字节,英文占用一个字节
        byte[] bytes2 = s.getBytes("gbk");
        for (byte b:bytes2) {
            //以字节形式输出
            System.out.print(b + ",");
            //把字节(转换成了Int)以十六进制形式输出,& 0xff把前面的0去掉,只留下后8位
            System.out.println(Integer.toHexString(b & 0xff));
        }

        System.out.println("----------UTF-16be编码----------");
        //java是双字节编码 URF-16be
        //URF-16be,中英文各占两字节
        byte[] bytes3 = s.getBytes("UTF-16be");
        for (byte b:bytes3) {
            //以字节形式输出
            System.out.print(b + ",");
            //把字节(转换成了Int)以十六进制形式输出,& 0xff把前面的0去掉,只留下后8位
            System.out.println(Integer.toHexString(b & 0xff));
        }

        /**
         * 当你的字节序列是某种编码时,这个时候想把字节序列变成字符串
         * 也需要用这种编码方式,否则会出现乱码
         */
        System.out.println("----------UTF-16be编码----------");

        String str1 = new String(bytes3);//用项目默认的编码
        System.out.println(str1);

        String str2 = new String(bytes3,"UTF-16be");//使用与项目一致的编码
        System.out.println(str2);

        /**
         * 文本文件 就是字节序列
         * 可以是任意编码的字节序列
         * 如果在中文机器上直接创建文本文件,那么该文本文件只认识ANSI编码
         */
    }
}
