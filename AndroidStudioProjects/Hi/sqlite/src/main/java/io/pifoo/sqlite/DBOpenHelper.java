package io.pifoo.sqlite;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by pifoo on 15/11/4.
 */
public class DBOpenHelper extends SQLiteOpenHelper {

    public DBOpenHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, null, 1);

    }

    @Override//首次创建数据库时调用，一般的建库、建表的操作
    public void onCreate(SQLiteDatabase db) {
        //创建表
        db.execSQL("create table if not exists stutb(" +
                "_id integer primary key autoincrement," +
                "name text not null,age integer not null," +
                "sex text not null)");
        db.execSQL("insert into usertb(name,sex,age) values('李一','男',18)");
    }

    @Override//当数据库的版本发生变化时会自动执行
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }
}
