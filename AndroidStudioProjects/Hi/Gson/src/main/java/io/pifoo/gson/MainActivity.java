package io.pifoo.gson;

import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.widget.ListView;

// TODO 数据没正常解析 http://www.imooc.com/video/8333
public class MainActivity extends AppCompatActivity {

    private ListView listView;
    private JsonAdapter adapter;
    private Handler handler = new Handler();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.json);
        listView = (ListView) findViewById(R.id.listView);

        adapter = new JsonAdapter(this);

        String url = "http://192.168.155.111:8080/JsonServerServlet";
        new HttpJson(url,handler,adapter,listView).start();










    }
}
