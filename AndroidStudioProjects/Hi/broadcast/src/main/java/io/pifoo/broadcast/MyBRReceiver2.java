package io.pifoo.broadcast;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * Created by pifoo on 15/10/22.
 */
public class MyBRReceiver2 extends BroadcastReceiver{

    @Override
    public void onReceive(Context context, Intent intent){
        String msg = intent.getStringExtra("msg");
        Log.i("Receive2 接收发送的广播内容", msg);
        //abortBroadcast(); //截断广播（无序广播不能截断

        //接收来自Receive2广播处理内容
        /*
        Bundle bundle = getResultExtras(true);
        String test = bundle.getString("test");
        Log.i("接收来自Receive2发送内容", test);*/





    }
}
