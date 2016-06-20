package io.pifoo.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

/**
 * Created by pifoo on 15/10/19.
 */
public class Activity2 extends Activity {

    private TextView txtshow;
    private String name;
    private String sex;

    private Button back;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity2);

        txtshow = (TextView)findViewById(R.id.txtshow);
        back = (Button)findViewById(R.id.back);

        //获得Intent对象,并且用Bundle取出里面的数据
        Intent it = getIntent();
        Bundle bd = it.getExtras();

        //按键值的方式取出Bundle中的数据
        name = bd.getCharSequence("name").toString();
        sex = bd.getCharSequence("sex").toString();
        txtshow.setText("尊敬的 " + name + " " + sex + "士, " + " 恭喜你,注册成功~");

        //bd.putCharSequence("resultText", txtshow.getText().toString());

        //TODO
        //回传数据到上一个Activity
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent it = new Intent(Activity2.this,MainActivity.class);
                Bundle bd = new Bundle();

                bd.putCharSequence("resultText", txtshow.getText().toString());

                Log.i("Activity2 resultText", txtshow.getText().toString());

                //将数据包Bundle绑定到Intent上
                it.putExtras(bd);

                //返回指定的Activity
                setResult(0x123, it);
                startActivity(it);
                //startActivityForResult(it, 0x123);//参数2：请求码
                finish();
            }
        });
    }

}
