package io.pifoo.net.socket;

import java.io.IOException;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Created by pifoo on 15/12/26.
 */
public class HelloServer {
    public static void main(String[] args) throws IOException {
        ServerSocket server = new ServerSocket(8888);   // 服务器在8888端口等待客户端的访问
        System.out.println(server + " 服务器运行,等待客户端连接 ");

        Socket client = server.accept();                // 程序阻塞,等待客户端连接
        PrintStream print = new PrintStream(client.getOutputStream()); // 实例化打印流对象,以向客户端输出

        String str = "hello world ......   !";

        print.print(str);           // 输出信息
        print.close();
        client.close();
        server.close();



    }
}
