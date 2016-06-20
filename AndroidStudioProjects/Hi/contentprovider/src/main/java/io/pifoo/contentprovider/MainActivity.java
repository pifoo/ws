package io.pifoo.contentprovider;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.StructuredName;
import android.provider.ContactsContract.RawContacts;
import android.provider.ContactsContract.CommonDataKinds.Email;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.Contacts;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final int READ_REQUEST_CODE = 42;
    private static String TAG = "INFO";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //为btn_show添加事件监听对象（2.4 4.直接使用Activity作为事件监听器: Activity实现对应接口,重写相关方法）
        Button btn_show = (Button) findViewById(R.id.btn_show);
        btn_show.setOnClickListener(this);


        ContentResolver cr = getContentResolver();

        //获取通讯录联系人信息
        Cursor c = cr.query(Contacts.CONTENT_URI, new String[]{Contacts._ID,
                Contacts.DISPLAY_NAME}, null, null, null);
        if (c != null) {
            while (c.moveToNext()) {
                int id = c.getInt(c.getColumnIndex("_id"));
                Log.i(TAG, "id:" + id);
                Log.i(TAG,
                        "name:" + c.getString(c.getColumnIndex("display_name")));
                Cursor c1 = cr.query(Phone.CONTENT_URI, new String[]{
                                Phone.NUMBER, Phone.TYPE},
                        Phone.CONTACT_ID + "=" + id, null, null);
                // 根据联系人ID查询出联系人的电话号码
                // if (c1 != null) {
                while (c1.moveToNext()) {
                    int type = c1.getInt(c1.getColumnIndex(Phone.TYPE));
                    if (type == Phone.TYPE_HOME) {
                        Log.i(TAG,
                                "家庭电话:"
                                        + c1.getString(c1
                                        .getColumnIndex(Phone.NUMBER)));
                    } else if (type == Phone.TYPE_MOBILE) {
                        Log.i(TAG,
                                "手机号:"
                                        + c1.getString(c1
                                        .getColumnIndex(Phone.NUMBER)));
                    }
                }
                c1.close();
            }
            // 根据联系人ID查询出联系人的emailַ
            Cursor c2 = cr.query(Email.CONTENT_URI, new String[]{
                            Email.DATA, Email.TYPE}, Email.CONTACT_ID + "=" + Email.CONTACT_ID, //+id
                    null, null);
            if (c2 != null) {
                while (c2.moveToNext()) {
                    int type = c2.getInt(c2.getColumnIndex(Email.DATA));
                    if (type == Email.TYPE_WORK) {
                        Log.i(TAG,
                                "工作邮箱"
                                        + c2.getString(c2
                                        .getColumnIndex(Email.DATA)));
                    }
                }
                c2.close();
            }
        }
        c.close();

        //向通讯录插入一行数据
        ContentValues values = new ContentValues();
        Uri uri = cr.insert(RawContacts.CONTENT_URI, values);
        Long raw_contract_id = ContentUris.parseId(uri);
        values.clear();
        //插入人名
        values.put(StructuredName.RAW_CONTACT_ID, raw_contract_id);
        values.put(StructuredName.DISPLAY_NAME, "Pifoo");
        values.put(StructuredName.MIMETYPE,StructuredName.CONTENT_ITEM_TYPE);
        uri = cr.insert(ContactsContract.Data.CONTENT_URI,values);
        //插入电话信息
        values.put(Phone.RAW_CONTACT_ID, raw_contract_id);
        values.put(Phone.NUMBER,"13112345678");
        values.put(Phone.MIMETYPE,Phone.CONTENT_ITEM_TYPE);
        uri = cr.insert(ContactsContract.Data.CONTENT_URI,values);



    }

    //打开看图应用
    @Override
    public void onClick(View v) {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("image/*");
        startActivityForResult(intent, READ_REQUEST_CODE);
    }
    //获取图片URI
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == READ_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            Uri uri;
            if (data != null) {
                uri = data.getData();
                Log.i(TAG, uri.toString());
            }
        }
    }


}
