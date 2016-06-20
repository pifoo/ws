package io.pifoo.gesturedetector;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    ImageView imageView;
    GestureDetector myGestureDetector;
    class MyGestureListener extends GestureDetector.SimpleOnGestureListener{
        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            if(e1.getX() - e2.getX() > 50){
                Toast.makeText(MainActivity.this,"从右往左滑",Toast.LENGTH_SHORT).show();
            }else if(e1.getX() - e2.getX() < 50) {
                Toast.makeText(MainActivity.this,"从左往右滑",Toast.LENGTH_SHORT).show();
            }
            return super.onFling(e1, e2, velocityX, velocityY);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imageView = (ImageView)findViewById(R.id.imageView);
        myGestureDetector = new GestureDetector(new MyGestureListener());
        imageView.setOnTouchListener(new View.OnTouchListener() {
            @Override// 可以捕获触摸屏幕所发生的Event事件
            public boolean onTouch(View v, MotionEvent event) {
                //1. 当接收到用户触摸消息时，将消息交给GestureDetector加工
                //2. 通过设置监听获得GestureDetector处理后的手势
                myGestureDetector.onTouchEvent(event);
                return true;
            }
        });
    }
}
