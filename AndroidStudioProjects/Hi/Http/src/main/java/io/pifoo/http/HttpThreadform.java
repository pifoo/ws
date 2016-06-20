package io.pifoo.http;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

/**
 * Created by pifoo on 15/12/4.
 */
public class HttpThreadform extends Thread {
    String url;
    String name;
    String age;

    public HttpThreadform(String url, String name, String age) {
        this.url = url;
        this.name = name;
        this.age = age;
    }

    public void doGet() throws IOException {
        url = url + "?name=" + URLEncoder.encode(name, "utf-8")  + "&age=" + age ;
        URL httpUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) httpUrl.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String str;
        StringBuffer sb = new StringBuffer();

        while ((str = reader.readLine()) != null){
            sb.append(str);
        }
        System.out.println("result: " + sb.toString());
    }
    public void doPost() throws IOException{
        // 取得OS的默认编码集
        Properties property = System.getProperties();
        property.list(System.out);

        URL httpUrl = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) httpUrl.openConnection();
        conn.setRequestMethod("POST");
        conn.setConnectTimeout(5000);
        OutputStream out = conn.getOutputStream();
        String content = "name=" + name + "&age=" + age;
        out.write(content.getBytes());
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuffer sb = new StringBuffer();
        String str;
        while ( (str=reader.readLine()) != null){
            sb.append(str);
        }
        System.out.println("result: " + sb.toString());
    }



    @Override
    public void run() {
        try {
            //doGet();
            doPost();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
