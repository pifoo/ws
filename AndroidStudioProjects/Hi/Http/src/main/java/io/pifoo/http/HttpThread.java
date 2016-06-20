package io.pifoo.http;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;
import android.os.Handler;
import android.webkit.WebView;
import android.widget.ImageView;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Created by pifoo on 15/12/4.
 * http://www.imooc.com/video/7214
 */
public class HttpThread extends Thread {
    private String url;

    private WebView webView;
    private ImageView imageView;

    private Handler handler;

    //加载网页
    public HttpThread(String url, WebView webView, Handler handler) {
        this.url = url;
        this.webView = webView;
        this.handler = handler;
    }

    //加载图片
    public HttpThread(String url, ImageView imageView, Handler handler) {
        this.url = url;
        this.imageView = imageView;
        this.handler = handler;
    }


    @Override
    public void run() {
        try {
            URL httpUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) httpUrl.openConnection();
            conn.setConnectTimeout(5000);
            conn.setRequestMethod("GET");

            /*
            下载图片
             */
            conn.setDoInput(true);//拿到一个输入流
            InputStream in = conn.getInputStream();
            FileOutputStream out = null;
            String fileName = String.valueOf(System.currentTimeMillis());
            File downloadFile = null;
            //判断SD卡是否已挂载
            if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
                File parent = Environment.getExternalStorageDirectory(); //获取SD卡根目录
                 downloadFile = new File(parent,fileName);
                out = new FileOutputStream(downloadFile);//写入SD卡
            }
            byte[] b = new byte[2*1024];
            int len;
            if(out!=null){
                while ((len=in.read(b)) != -1){
                    out.write(b,0,len);
                }
            }
            final Bitmap bitmap = BitmapFactory.decodeFile(downloadFile.getAbsolutePath());
            handler.post(new Runnable() {
                @Override
                public void run() {
                    imageView.setImageBitmap(bitmap);
                }
            });



           /*加载网页
            final StringBuffer sb = new StringBuffer();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String str;
            while ((str = reader.readLine()) != null){
                sb.append(str);
            }

            handler.post(new Runnable() {
                @Override
                public void run() {
                    webView.loadData(sb.toString(),"text/html;charset=utf-8",null);
                }
            });*/

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
