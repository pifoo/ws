package io.pifoo.net;

import java.net.InetAddress;

/**
 * Created by pifoo on 15/12/26.
 */
public class InetAddressDemom {
    public static void main(String[] args) throws Exception {
        InetAddress locAdd = InetAddress.getLocalHost();
        InetAddress redAdd = InetAddress.getByName("https://www.baidu.com/");

        System.out.println("本机IP: " + locAdd.getHostAddress());
        System.out.println("baidu IP: " + redAdd.getHostAddress());
        System.out.println("本机是否可达 :" + locAdd.isReachable(3000));
    }
}
