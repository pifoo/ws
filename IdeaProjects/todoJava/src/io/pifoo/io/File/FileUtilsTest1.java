package io.pifoo.io.File;

import java.io.File;
import java.io.IOException;

/**
 * Created by pifoo on 15/11/16.
 */
public class FileUtilsTest1 {
    public static void main(String[] args) throws IOException {
        FileUtils.listDirectory(new File("/Users/pifoo/IdeaProjects/todoJava/src"));
    }
}
