/*
 * by:http://blog.csdn.net/coder_pig/article/details/48157807
 */

package io.pifoo.adapter;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private static String TAG = "事件";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 1\构造数据
        String[] strs1 = {"基神", "B神", "翔神", "曹神", "J神", "Q神", "B神", "翔神", "曹神", "J神", "Q神", "B神", "翔神", "曹神", "J神", "Q神"};
        // 2\支持泛型方式
        List<String> strs2 = new ArrayList<String>();
        strs2.add("基神");
        strs2.add("B神");
        strs2.add("翔神");
        //创建ArrayAdapter
        ArrayAdapter<String> adapter = new ArrayAdapter<String>
                (this, android.R.layout.simple_expandable_list_item_1, strs1);
        //参数2：系统提供的一些ListView模板
        //获取ListView对象，通过调用setAdapter方法为ListView设置Adapter设置适配器
        ListView list_test = (ListView) findViewById(R.id.list_test);
        list_test.setAdapter(adapter);

        Log.v("V", "VERBOSE");
        Log.d("D", "DEBUG");
        Log.i("I", "INFO");
        Log.w("W", "WARN");
        Log.e("E", "ERROR");

        // Activity生命周期
        //super.onCreate();
        //super.onStart();
        //super.onResume();
        //super.onPause();
        //super.onDestroy();


    }
}
