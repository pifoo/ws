package io.pifoo.sqlite;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Window;

/**
 * Created by pifoo on 15/11/4.
 * ContentValues
 */
public class SQLite2 extends AppCompatActivity {
    private static final String TAG = "SQLite2";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //隐藏标题栏
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_main);

        //创建一个数据库并打开
        SQLiteDatabase db = openOrCreateDatabase("stu.db",MODE_PRIVATE, null);
        //创建一张表
        db.execSQL("create table if not exists stutb(" +
                "_id integer primary key autoincrement," +
                "name text not null,age integer not null," +
                "sex text not null)");

        ContentValues values = new ContentValues();

        //插入数据
        values.put("name", "王一一");
        values.put("age", 19);
        values.put("sex", "男");
        long rowId = db.insert("stutb",null,values);
        values.clear();

        values.put("name", "王二二");
        values.put("age", 9);
        values.put("sex", "男");
        db.insert("stutb", null, values);
        values.clear();

        values.put("name", "王三三");
        values.put("age",29);
        values.put("sex", "男");
        db.insert("stutb", null, values);
        values.clear();

        values.put("name","王四四");
        values.put("age",19);
        values.put("sex", "男");
        db.insert("stutb", null, values);
        values.clear();

        values.put("name","王五五");
        values.put("age",49);
        values.put("sex", "男");
        db.insert("stutb", null, values);
        values.clear();

        //更新数据
        values.put("sex", "女");
        db.update("stutb", values, "_id>?", new String[]{"3"});//将ID大于3的人的性别改为女
        db.delete("stutb", "name like ?", new String[]{"%五%"});//删除名字包含五的人
        Cursor c = db.query("stutb", null, "_id>?", new String[]{"0"}, null, null, "age");
        if(c != null){
            String[] columns = c.getColumnNames();//查询出所有字段
            while (c.moveToNext()){
                for(String columnName : columns){
                    Log.i(TAG,c.getString(c.getColumnIndex(columnName)));
                }
                Log.i(TAG,"----------------------");
            }
            c.close();
        }
        db.close();

    }
}
