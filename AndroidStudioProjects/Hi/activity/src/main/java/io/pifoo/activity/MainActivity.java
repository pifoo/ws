package io.pifoo.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

public class MainActivity extends Activity {

    private Button btnregister;
    private EditText editname;
    private RadioGroup rad;

    //private TextView resultTx;

    private String resultText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnregister = (Button)findViewById(R.id.btnregister);
        editname = (EditText)findViewById(R.id.editname);
        rad = (RadioGroup)findViewById(R.id.radioGroup);

        TextView resultTx = (TextView)findViewById(R.id.resultTx);

        btnregister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String name, sex = "";
                Intent it = new Intent(MainActivity.this, Activity2.class);

                //启动第二个Activity
                //startActivityForResult(it,0x123);

                name = editname.getText().toString();

                //遍历RadioGroup找出被选中的单选按钮
                for(int i = 0;  i < rad.getChildCount(); i++){
                    RadioButton rd = (RadioButton)rad.getChildAt(i);
                    if(rd.isChecked()){
                        sex = rd.getText().toString();
                        break;
                    }
                }

                //新建Bundle对象,并把数据写入
                Bundle bd = new Bundle();
                bd.putCharSequence("name", name);
                bd.putCharSequence("sex", sex);

                //将数据包Bundle绑定到Intent上
                it.putExtras(bd);
                //startActivity(it);
                startActivityForResult(it,0x123);//参数2：请求码
                finish();
            }
        });

    }

    //TODO
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 0x123 && resultCode == 0x123) {

            Bundle bd = data.getExtras();
            resultText = bd.getCharSequence("resultText").toString();

            Log.i("Activity2 resultText", resultText);

            //获取布局文件中的TextView组件
            TextView resultTx = (TextView)findViewById(R.id.resultTx);
            resultTx.setText(resultText);
        }
    }
}
