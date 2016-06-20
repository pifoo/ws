package io.pifoo.event;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.Button;

/**
 * Created by pifoo on 15/10/15.
 */
public class MyButton extends Button {
    private static String TAG = "Log";
    public MyButton(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    //重写键盘按下触发的事件
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        super.onKeyDown(keyCode, event);
        Log.i(TAG, "onKeyDown方法被调用");
        return false;
    }
}
