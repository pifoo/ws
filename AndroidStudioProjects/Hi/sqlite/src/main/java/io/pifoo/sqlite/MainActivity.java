package io.pifoo.sqlite;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

public class MainActivity extends AppCompatActivity {
    private static final String TAG = "SQLite";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //创建一个数据库并打开
        SQLiteDatabase db = openOrCreateDatabase("user.db",MODE_PRIVATE, null);
        //创建一张表
        db.execSQL("create table if not exists usertb(" +
                "_id integer primary key autoincrement," +
                "name text not null,age integer not null," +
                "sex text not null)");
        //插入数据
        db.execSQL("insert into usertb(name,sex,age) values('张一','男',18)");
        db.execSQL("insert into usertb(name,sex,age) values('张二','男',8)");
        db.execSQL("insert into usertb(name,sex,age) values('张三','女',19)");
        db.execSQL("insert into usertb(name,sex,age) values('张四','女',20)");

        //查询数据
        Cursor c = db.rawQuery("select * from usertb", null); //返回游标对象,可理解为返回的一个数据集合list
        if(c != null){
            while (c.moveToNext()){ //每次查询一条数据
                Log.i(TAG,"_id:"+c.getInt(c.getColumnIndex("_id")));
                Log.i(TAG,"name:"+c.getString(c.getColumnIndex("name")));
                Log.i(TAG,"age:"+c.getInt(c.getColumnIndex("age")));
                Log.i(TAG,"sex:"+c.getString(c.getColumnIndex("sex")));
                Log.i(TAG,"-----------------------------");

            }
            c.close();
        }
        db.close();

        /**
         * 使用SQLiteOpenHelper类
         */
        //
        DBOpenHelper helper = new DBOpenHelper(MainActivity.this,"stu.db",null,1);
        //helper.getReadableDatabase();//获取一个只读的数据库
        SQLiteDatabase db2 = helper.getWritableDatabase();
        //查询数据
        Cursor c2 = db2.rawQuery("select * from usertb", null); //返回游标对象,可理解为返回的一个数据集合list
        if(c2 != null){
            //查询出所有字段
            String[] columns = c.getColumnNames();
            while (c2.moveToNext()){
                for(String columnName : columns){
                    Log.i(TAG,c2.getString(c2.getColumnIndex(columnName)));
                }
                Log.i(TAG,"----------------------");
            }
            c2.close();
        }
        db2.close();


    }
}
