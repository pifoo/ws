package io.pifoo.datafile;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import java.io.File;
import java.io.IOException;

public class MainActivity extends AppCompatActivity {
    private static final String TAG = "DataFile";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //TODO
        File file = new File("/mnt/sdcard/FileTest");
        if(!file.exists()){
            try{
                file.createNewFile();
                Log.i(TAG, "文件创建成功！");
            }catch (IOException e){
                Log.i(TAG,e.toString());
            }

        }else {
            Log.i(TAG,"文件已经存在！");
        }
        file.delete();


        File filePath = this.getFilesDir();
        Log.i(TAG,filePath.toString());
    }
}
