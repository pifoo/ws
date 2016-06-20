package io.pifoo.as;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import io.pifoo.hi.R;

/**
 * Created by pifoo on 15/11/5.
 */
public class AsGuide extends Activity {
    /**
     * Live Templates
     */
    //const
    private static final int Num = 874;
    //key
    private static final String KEY_ID = "ID";

    int Arr[] = {1,2,3,4,5,6};




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //foreach
        for (int a:Arr) {   }

        //IntentView
        Intent view = new Intent();
        view.setAction(Intent.ACTION_VIEW);
        view.setData(Uri.parse(""));
        startActivity(view);

    }





}
