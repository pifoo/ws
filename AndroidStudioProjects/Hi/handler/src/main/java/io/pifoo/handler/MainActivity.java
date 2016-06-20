package io.pifoo.handler;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.widget.ImageView;

import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends Activity {

    ImageView imgChange;

    //定义图片素材数组id
    int imgIds[] = new int[]{
        R.drawable.wifi_0,R.drawable.wifi_1,R.drawable.wifi_2,
            R.drawable.wifi_3,R.drawable.wifi_4,R.drawable.wifi_5
    };
    int imgStart = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imgChange = (ImageView)findViewById(R.id.imgChange);

        //使用定时器,每隔200毫秒让handler发送一个空信息
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                myHandler.sendEmptyMessage(0x123);
            }
        }, 0, 200);

    }

     Handler myHandler = new Handler(){
        //重写handleMessage方法,根据msg中what的值判断是否执行后续操作
        @Override
        public void handleMessage(Message msg){
            if(msg.what == 0x123){
                imgChange.setImageResource(imgIds[imgStart++ % 6]);
            }
        }
    };

}

//Android 用Animation-list实现逐帧动画
//http://blog.csdn.net/aminfo/article/details/7847761