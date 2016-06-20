package io.pifoo.service2;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

public class MyBindService extends Service {
    private static String TAG = "MyBindService";

    //1. 新建Service类MyBindService。在MyBindService类里新建内部类MyBinder，
    //继承自Binder(Binder实现IBinder接口)。MyBinder提供方法返回MyBindService实例。
    public class MyBinder extends Binder {
        public MyBindService getService(){
            return MyBindService.this;//返回服务对象
        }
    }

    //2. //返回Binder对象
    @Override//IBinder接口实例，返回一个ServiceConnection对象给启动源
    public IBinder onBind(Intent intent) {
        Log.i(TAG, "---- onBind()");
        return new MyBinder(); //返回IBinder对象
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "---- onCreate()");
    }

    @Override
    public boolean onUnbind(Intent intent) {
        Log.i(TAG, "---- onUnbind()");
        return super.onUnbind(intent);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, "---- onDestroy()");
    }

    public void play() {
        Log.i(TAG, "---- Play");
    }

    public void pause() {
        Log.i(TAG, "---- Pause");
    }

    public void pervious() {
        Log.i(TAG, "---- Pervious");
    }

    public void next() {
        Log.i(TAG, "---- next");

    }

}