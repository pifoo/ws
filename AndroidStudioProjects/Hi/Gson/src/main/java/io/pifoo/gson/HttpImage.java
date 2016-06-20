package io.pifoo.gson;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.widget.ImageView;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by pifoo on 15/12/7.
 */
public class HttpImage extends Thread {
    private ImageView imageView;
    private String url;

    private Handler handler;


    public HttpImage(String url,Handler handler, ImageView imageView) {
        this.url = url;
        this.handler = handler;
        this.imageView = imageView;
    }

    @Override
    public void run() {
        try {
            URL httpUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) httpUrl.openConnection();
            conn.setConnectTimeout(5000);
            conn.setRequestMethod("GET");

            InputStream in = conn.getInputStream();
            Bitmap bitmap = BitmapFactory.decodeStream(in);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
