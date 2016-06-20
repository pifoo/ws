package io.pifoo.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

public class ActivtyLifecycle extends AppCompatActivity {
    private static String TAG = "ActivtyLifecycle";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lifecycle);

        Log.i(TAG, "onCreate() 执行……");
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.i(TAG, "onStart() 执行……");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.i(TAG, "onResume() 执行……");
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.i(TAG, "onPause() 执行……");
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.i(TAG, "onStop() 执行……");
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.i(TAG, "onRestart() 执行……");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        android.os.Debug.stopMethodTracing();
        Log.i(TAG, "onDestroy() 执行……");
    }


}
