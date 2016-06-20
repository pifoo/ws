package io.pifoo.broadcast;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * Created by pifoo on 15/10/22.
 */
public class MyBRReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        String msg = intent.getStringExtra("msg");
        Log.i("Receive1 接收发送的广播内容", msg);

        //有序广播：截断广播的有序传播，并处理广播
        /*
        Bundle bundle = new Bundle();
        bundle.putString("test", "广播处理的数据");
        setResultExtras(bundle);*/

        //abortBroadcast();   //截断有序广播






    }
}
