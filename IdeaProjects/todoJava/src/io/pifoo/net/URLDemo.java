package io.pifoo.net;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Scanner;

/**
 * Created by pifoo on 15/12/26.
 */
public class URLDemo {
    public static void main(String[] args) throws IOException {
        URL url = new URL("https","www.baidu.com","80");
        InputStream inputStream = url.openStream();         // 打开输入流,读取URL内容
        Scanner scanner = new Scanner(inputStream);         // 实例化Scanner
        scanner.useDelimiter("\n");                         // 设置读取分隔符
        while (scanner.hasNext()){                          // 不断读取内容
            System.out.println(scanner.next());
        }

        URL url2 = new URL("https://www.baidu.com/");
        URLConnection con = url2.openConnection();          // 建立连接
        System.out.println("\n\n内容大小: " + con.getContentLength());
        System.out.println("内容类型: " + con.getContentType());

        String str = "pifoo 匹夫";
        String encod = URLEncoder.encode(str,"UTF-8");
        System.out.println("编码后: " + encod);
        String decod = URLDecoder.decode(encod,"UTF-8");
        System.out.println("解码后: " + decod);


    }
}
