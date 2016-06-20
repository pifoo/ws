package io.pifoo.io.dataStream;

import java.io.*;

import io.pifoo.io.inputStream.IOUtil;

/**
 * Created by pifoo on 15/11/17.
 * DataOutputStream / DataInputStream
 */
public class DataStreamDemo {

    public static void main(String[] args) throws IOException {
        String file = "/Users/pifoo/IdeaProjects/todoJava/src/io/pifoo/io/dataStream/dos.txt";
        //写入数据
        DataOutputStream dos = new DataOutputStream(new FileOutputStream(file));
        dos.writeInt(10);
        dos.writeInt(-10);
        dos.writeLong(10l);
        dos.writeDouble(5.5);
        dos.writeUTF("中国");//以UTF-8编码写出
        dos.writeChars("中国");//以UTF-16be编码写出
        dos.close();

        IOUtil.printHex(file);
        System.out.println();
        IOUtil.printHexByByteArray(file);
        System.out.println();

        //读取数据
        DataInputStream dis = new DataInputStream(new FileInputStream(file));
        int i = dis.readInt();
        System.out.println("\n" + i);
        System.out.println(dis.readInt());
        System.out.println(dis.readLong());
        System.out.println(dis.readDouble());
        System.out.println(dis.readUTF());
        System.out.println(dis.readChar());
        dis.close();

    }

}
