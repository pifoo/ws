package io.pifoo.broadcast;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * Created by pifoo on 15/10/22.
 */
public class MyBRReceiver3 extends BroadcastReceiver{

    @Override
    public void onReceive(Context context, Intent intent){
        String msg = intent.getStringExtra("msg");
        Log.i("Receive3 接收发送的广播内容", msg);
        //abortBroadcast(); //截断广播（无序广播不能截断







    }
}
