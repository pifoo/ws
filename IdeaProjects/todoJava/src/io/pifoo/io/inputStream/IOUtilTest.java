package io.pifoo.io.inputStream;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

/**
 * Created by pifoo on 15/11/17.
 */
public class IOUtilTest {
    public static void main(String[] args) {

        System.out.println("----------IOUtil.printHex()----------");

        try {
            IOUtil.printHex("/Users/pifoo/IdeaProjects/todoJava/src/io/pifoo/io/File/note.md");
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("----------IOUtil.printHexByByteArray----------");

        try {
            IOUtil.printHexByByteArray("/Users/pifoo/IdeaProjects/todoJava/src/io/pifoo/io/File/note.md");
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("\n----------文件copy比较----------");
        try {
            long start = System.currentTimeMillis();

            IOUtil.copyFile(new File("/Users/pifoo/IdeaProjects/todoJava/out/copy.txt"),
                    new File("/Users/pifoo/IdeaProjects/todoJava/out/copy1.txt"));

            IOUtil.copyFileByBuffer(new File("/Users/pifoo/IdeaProjects/todoJava/out/demo.txt"),
                    new File("/Users/pifoo/IdeaProjects/todoJava/out/demo1.txt"));

            IOUtil.copyFileByByte(new File("/Users/pifoo/IdeaProjects/todoJava/out/test.txt"),
                    new File("/Users/pifoo/IdeaProjects/todoJava/out/test1.txt"));

            long end = System.currentTimeMillis();
            System.out.println("IOUtil.copyFile() 耗时:" + (end-start));
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
