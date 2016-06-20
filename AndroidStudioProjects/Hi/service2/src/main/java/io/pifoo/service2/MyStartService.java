package io.pifoo.service2;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

public class MyStartService extends Service {
    private static String TAG = "MyStartService";

    //必须要实现的方法
    @Override
    public IBinder onBind(Intent intent) {
        Log.i(TAG, "---- onBind()");
        return null;
    }
    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG," ---- onCreate()");
    }
    //Service被启动时调用
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i(TAG," ---- onStartCommand()");
        return super.onStartCommand(intent, flags, startId);
    }
    //Service被关闭之前回调
    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, " ---- onDestroy()");
    }
}
