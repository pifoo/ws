package io.pifoo.broadcast;

import android.app.Activity;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends Activity {

    private MyBRReceiver3 myBRReceiver3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //动态注册Receiver2  （ 同级别动态注册高于静态注册 ，只能作用于当前程序运行时……
        /*IntentFilter intentFilter = new IntentFilter("io.pifoo.broadcast.SEND1");
        MyBRReceiver2 myBRReceiver2 = new MyBRReceiver2();
        registerReceiver(myBRReceiver2,intentFilter);*/
    }
    public void doClick(View v) {
        switch (v.getId()){
            case R.id.send1: //发送普通广播
                Intent intent = new Intent();
                intent.putExtra("msg", "这是一条普通广播");
                intent.setAction("io.pifoo.broadcast.SEND1");
                sendBroadcast(intent);
                //sendOrderedBroadcast(intent,null);
                break;
            case R.id.send2: //发送有序广播
                Intent intent2 = new Intent();
                intent2.putExtra("msg", "这是一条有序广播");
                intent2.setAction("io.pifoo.broadcast.SEND1");
                sendOrderedBroadcast(intent2, null);
                break;
            case R.id.send3: //发送异步广播
                Intent intent3 = new Intent();
                intent3.putExtra("msg", "这是一条异步广播");
                intent3.setAction("io.pifoo.broadcast.SEND3");
                sendStickyBroadcast(intent3);

                //先发送广播  后注册广播
                IntentFilter intentFilter = new IntentFilter("io.pifoo.broadcast.SEND3");
                myBRReceiver3 = new MyBRReceiver3();
                registerReceiver(myBRReceiver3,intentFilter);
                break;
        }
    }

    @Override
    protected void onDestroy() {  //动态注册 及时注销
        super.onDestroy();
        unregisterReceiver(myBRReceiver3);
    }
}
