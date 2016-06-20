package io.pifoo.http;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

/**
 * Created by pifoo on 15/12/4.
 *
 */
public class RegistActivity extends AppCompatActivity{
    private EditText name;
    private EditText age;
    private Button regist;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.regist);
        name = (EditText) findViewById(R.id.name);
        age = (EditText) findViewById(R.id.age);
        regist = (Button) findViewById(R.id.regist);

        regist.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = "http://10.99.117.5:8080/servlet";

                //new HttpThreadform(url, name.getText().toString(), age.getText().toString()).start();

                /*url += "?name=" + name.getText().toString()  + "&age=" + age.getText().toString();
                new HttpClientThread(url).start();*/

                new HttpClientThread(url,name.getText().toString(),age.getText().toString()).start();


            }
        });



    }
}
