package io.pifoo.service2;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;

public class MainActivity extends AppCompatActivity {
    Intent intent1;
    Intent intent2;
    MyBindService service;

    //3. 通过ServiceConnected对象的相关方法得到service对象
    ServiceConnection conn = new ServiceConnection() {
        @Override//当启动源与Service成功连时自动调用
        public void onServiceConnected(ComponentName name, IBinder binder) {
            //TODO
            service = ((MyBindService.MyBinder)binder).getService();
            Log.i("Service", "onServiceConnected===");
        }

        @Override//当启动源与Service的连接意外丢失失调用
        public void onServiceDisconnected(ComponentName name) {
            Log.i("Service", "onServiceDisconnected===");
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }


    public void doClick(View v) {
        switch (v.getId()) {
            case R.id.start:
                intent1 = new Intent(MainActivity.this, MyStartService.class);
                startService(intent1);
                break;

            case R.id.stop:
                stopService(intent1);
                break;

            case R.id.bind:
                intent2 = new Intent(MainActivity.this, MyBindService.class);
                startService(intent2);
                bindService(intent2, conn, Service.BIND_AUTO_CREATE);//参数三：让服务自动创建
                break;

            case R.id.play:
                service.play();
                break;

            case R.id.pause:
                service.pause();
                break;

            case R.id.next:
                service.next();
                break;

            case R.id.previous:
                service.pervious();
                break;

            case R.id.unBind:
                unbindService(conn);
                break;
        }
    }

    @Override
    protected void onDestroy() {
        stopService(intent2);
        unbindService(conn);
        super.onDestroy();
    }
}
