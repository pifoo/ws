package io.pifoo.http;

import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.webkit.WebView;
import android.widget.ImageView;


public class MainActivity extends AppCompatActivity {
    private WebView webView;
    private ImageView imageView;
    private Handler handler = new Handler();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webView = (WebView)findViewById(R.id.webView);
        imageView = (ImageView)findViewById(R.id.imageView);

        //加载网页
        //new HttpThread("http://m.baidu.com/",webView, handler).start();
        //下载图片
        new HttpThread("http://images.dmzj.com/webpic/6/yhnxs.jpg",imageView,handler).start();
    }
}
