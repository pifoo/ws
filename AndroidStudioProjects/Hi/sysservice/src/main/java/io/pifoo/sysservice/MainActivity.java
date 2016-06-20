package io.pifoo.sysservice;

import android.app.ActivityManager;
import android.content.Context;
import android.media.AudioManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //获取系统服务
        //得到一个填充器
        LayoutInflater inflater = (LayoutInflater)MainActivity.this.getSystemService(LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.activity_main, null);
        setContentView(view);
    }

    public void doClick(View v){
        switch (v.getId()){
            case R.id.network:
                if(isNetWorkConnected(MainActivity.this) == true){
                    Toast.makeText(MainActivity.this,"网络已打开",Toast.LENGTH_SHORT).show();
                }else {
                    Toast.makeText(MainActivity.this,"网络未连接",Toast.LENGTH_SHORT).show();
                }
                break;
            case R.id.enableOrDisable_WiFi:
                Button btnEnableOrDisable_WiFi = (Button)findViewById(R.id.enableOrDisable_WiFi);
                WifiManager mWifiManager = (WifiManager)MainActivity.this.getSystemService(this.WIFI_SERVICE);
                if(mWifiManager.isWifiEnabled()){
                    mWifiManager.setWifiEnabled(false);
                    Toast.makeText(MainActivity.this,"WiFi已关闭",Toast.LENGTH_SHORT).show();
                    btnEnableOrDisable_WiFi.setText("WiFi已关闭");
                }else {
                    mWifiManager.setWifiEnabled(true);
                    Toast.makeText(MainActivity.this,"WiFi已打开",Toast.LENGTH_SHORT).show();
                    btnEnableOrDisable_WiFi.setText("WiFi已打开");
                }
                break;
            case R.id.vol:
                AudioManager mAudioManager = (AudioManager)MainActivity.this.getSystemService(AUDIO_SERVICE);
                int maxVol = mAudioManager.getStreamMaxVolume(AudioManager.STREAM_SYSTEM);
                int currentVol = mAudioManager.getStreamVolume(AudioManager.STREAM_RING);
                Toast.makeText(MainActivity.this,"设备最大音量"+maxVol+"; 当前音量"+currentVol,Toast.LENGTH_SHORT).show();
                break;
            case R.id.getPackageName:
                ActivityManager mActivityManager = (ActivityManager)MainActivity.this.getSystemService(ACTIVITY_SERVICE);
                String packageName = mActivityManager.getRunningTasks(1).get(0).topActivity.getPackageName();
                Toast.makeText(MainActivity.this,"当前运行的Activity包名："+packageName,Toast.LENGTH_SHORT).show();
        }
    }

    public boolean isNetWorkConnected(Context context){
        if(context != null){
            ConnectivityManager mConnectivityManager = (ConnectivityManager)context.getSystemService(CONNECTIVITY_SERVICE);
            NetworkInfo mNetworkInfo = mConnectivityManager.getActiveNetworkInfo();
            if(mNetworkInfo != null){
                return mNetworkInfo.isAvailable();
            }
        }
        return false;
    }
}
