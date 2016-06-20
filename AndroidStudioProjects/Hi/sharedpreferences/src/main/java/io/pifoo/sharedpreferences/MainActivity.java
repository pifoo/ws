package io.pifoo.sharedpreferences;

import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

public class MainActivity extends AppCompatActivity {
    private static String TAG = "SharedPreferences";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //SharedPreferences pref = PreferenceManager.getDefaultSharedPreferences(MainActivity.this);
        SharedPreferences pref = getSharedPreferences("myPref",MODE_PRIVATE);//参数2：权限
        Editor editor = pref.edit();
        editor.putString("name","张三");
        editor.putInt("age", 30);
        editor.putLong("time", System.currentTimeMillis());
        editor.putBoolean("default", true);
        editor.commit();
        editor.remove("default");
        editor.commit();

        Log.i(TAG, pref.getString("name", ""));
        Log.i(TAG, pref.getInt("age", 0) + "");//转换成字符串输出
        Log.i(TAG, pref.getLong("time", 0) + "");

    }
}
