package io.pifoo.io.frAndFw;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by pifoo on 15/11/18.
 * FileReader & FileWriter
 */
public class FrAndFwDemo {
    public static void main(String[] args) throws IOException {
        FileReader fr = new FileReader("/Users/pifoo/IdeaProjects/todoJava/out/test.txt");
        FileWriter fw = new FileWriter("/Users/pifoo/IdeaProjects/todoJava/out/test1.txt",true);
        //读写操作
        char[] buffer = new char[2056];
        int c;
        while ((c=fr.read(buffer,0,buffer.length)) != -1){
            fw.write(buffer,0,c);
            fw.flush();
        }
        fr.close();
        fw.close();

    }
}
