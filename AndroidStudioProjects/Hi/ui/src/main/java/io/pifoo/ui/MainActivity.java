package io.pifoo.ui;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    //private TextView textView;

    private Button btnOne, btnTwo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.btn);

        /*
        沉浸式状态栏(像ios那样的状态栏与应用统一颜色样式)
         */
        //透明状态栏
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
        //透明导航栏
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);

        //设置按钮效果
        btnOne = (Button) findViewById(R.id.btnOne);
        btnTwo = (Button) findViewById(R.id.btnTwo);
        btnTwo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (btnTwo.getText().toString().equals("按钮不可用")) {
                    btnOne.setEnabled(false);
                    btnTwo.setText("按钮可用");
                    Log.i("btnTwoBtn", "按钮可用");
                    Toast toast = Toast.makeText(getApplicationContext(), "按钮可用", Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.TOP | Gravity.CENTER, 0, 300);
                    toast.show();
                } else {
                    btnOne.setEnabled(true);
                    btnTwo.setText("按钮不可用");
                    Log.i("btnTwoBtn", "按钮不可用");
                    Toast.makeText(getApplicationContext(), "按钮不可用", Toast.LENGTH_SHORT).show();
                }
            }
        });




        /*
         * 设置TextView drawable大小
         */
        //textView = (TextView)findViewById(R.id.txtOne);
        //获得四个不同方向上的图片资源,数组元素依次是:左上右下的图片
        //Drawable[] drawable = textView.getCompoundDrawables();
        //获得资源后,可以调用setBounds设置左上右下坐标点,比如这里设置了代表的是:
        //长是:从离文字最左边开始100dp处到200dp处
        //宽是:从文字上方0dp处往上延伸200dp!
        // (数组下表0~3,依次是:左上右下)
        //drawable[1].setBounds(100, 0, 200, 200);
        //为TextView重新设置drawable数组!没有图片可以用null代替
        //在Java代码中也可以调用setCompoundDrawables为TextView设置图片！！
        //textView.setCompoundDrawables(drawable[0], drawable[1], drawable[2], drawable[3]);


        //TextView玩转HTML
        //String s1 = "<font color='blue'><b>百度!!</b></font><br>";
        //s1 += "<a href='http://www.baidu.com'>百度</a>";
        //textView.setText(Html.fromHtml(s1));
        //textView.setMovementMethod(LinkMovementMethod.getInstance());



/*
        //随手指移动的ICON
        FrameLayout frame = (FrameLayout) findViewById(R.id.myFrame);
        final MovIconView movIconView = new MovIconView(MainActivity.this);
        //为我们的ICON添加触摸事件监听器
        movIconView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent event) {
                //设置ICON显示的位置
                movIconView.bitmapX = event.getX() - 150;
                movIconView.bitmapY = event.getY() - 150;

                //调用重绘方法
                movIconView.invalidate();
                return true;
            }
        });
        frame.addView(movIconView);
*/






/*
        TextView t1 = (TextView) findViewById(R.id.txtOne);
        //TextView t2 = (TextView) findViewById(R.id.txtTwo);

        SpannableString span = new SpannableString("红色打电话斜体删除线绿色下划线图片:.");

        //1.设置背景色,setSpan时需要指定的flag,Spanned.SPAN_EXCLUSIVE_EXCLUSIVE(前后都不包括)
        span.setSpan(new ForegroundColorSpan(Color.RED), 0, 2, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //2.用超链接标记文本
        span.setSpan(new URLSpan("tel:4155551212"), 2, 5, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //3.用样式标记文本（斜体）
        span.setSpan(new StyleSpan(Typeface.BOLD_ITALIC), 5, 7, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //4.用删除线标记文本
        span.setSpan(new StrikethroughSpan(), 7, 10, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //5.用下划线标记文本
        span.setSpan(new UnderlineSpan(), 10, 16, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //6.用颜色标记
        span.setSpan(new ForegroundColorSpan(Color.GREEN), 10, 13, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

        //7.//获取Drawable资源
        Drawable d = getResources().getDrawable(R.drawable.icon);
        d.setBounds(0, 0, d.getIntrinsicWidth(), d.getIntrinsicHeight());

        //8.创建ImageSpan,然后用ImageSpan来替换文本
        ImageSpan imgspan = new ImageSpan(d, ImageSpan.ALIGN_BASELINE);
        span.setSpan(imgspan, 18, 19, Spannable.SPAN_INCLUSIVE_EXCLUSIVE);

        t1.setText(span);
*/
    }

}
