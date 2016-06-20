package io.pifoo.net.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

/**
 * Created by pifoo on 15/12/26.
 */
public class HelloClient {
    public static void main(String[] args) throws IOException {
        Socket client = new Socket("localhost", 8888);
        // 声明 BufferedReader 对象接收信息
        BufferedReader buf = new BufferedReader(
                new InputStreamReader(client.getInputStream())      // 取得 客户端的输入流
        );

        String str = buf.readLine();                    // 读取信息
        System.out.println("服务器端输出内容: " + str);
        client.close();
        buf.close();
    }
}
