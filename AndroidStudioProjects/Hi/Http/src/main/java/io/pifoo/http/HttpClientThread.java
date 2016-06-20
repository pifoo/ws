package io.pifoo.http;


import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by pifoo on 15/12/4.
 * httpCliebt
 */
//TODO
public class HttpClientThread extends Thread {
    private String url;

    private String age;
    private String name;

    public HttpClientThread(String url){ //get方式 构造方法
        this.url = url;
    }

    public HttpClientThread(String url, String name, String age){ //post方式 构造方法
        this.url = url;
    }

    private void doHttpClientPost() throws IOException {
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);
        //通过NameValuePair存储数据
        ArrayList<NameValuePair> list = new ArrayList<NameValuePair>();
        list.add(new BasicNameValuePair("name",name));
        list.add(new BasicNameValuePair("age", age));
        //设置要发送的数据
        post.setEntity(new UrlEncodedFormEntity(list));
        HttpResponse response = client.execute(post);//发送post请求

        if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
            String conntent = EntityUtils.toString(response.getEntity());
            //System.out.println("conntent-------> " + conntent);
        }
    }

    private void doHttpClientGet() throws IOException {
        //1. 创建HttpGet对象
        HttpGet httpGet = new HttpGet(url);
        //2. 创建HttpClient对象
        HttpClient client = new DefaultHttpClient();
        //3. 发送请求
        HttpResponse response = client.execute(httpGet);
        //4. 判断类型
        if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
            //5. 取出服务器返回的数据
            String conntent = EntityUtils.toString(response.getEntity());
            System.out.println("conntent-------> " + conntent);
        }
    }

    @Override
    public void run() {
        try {
            //doHttpClientGet();
            doHttpClientPost();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
