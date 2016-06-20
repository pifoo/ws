package io.pifoo.gson;

import android.content.Context;
import android.os.Handler;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pifoo on 15/12/7.
 * 解析json
 */
public class HttpJson extends Thread{

    private String url;
    private Context context;
    private ListView listView;
    private JsonAdapter adapter;
    private Handler handler;

    public HttpJson(String url, Handler handler, JsonAdapter adapter, ListView listView) {
        this.url = url;
        this.handler = handler;
        this.listView = listView;
        this.adapter = adapter;
    }

    //TODO
    public void HttpJson(String url,Context context,ListView listView,JsonAdapter adapter){
        this.url = url;
        this.context = context;
        this.listView = listView;
        this.adapter = adapter;
    }

    @Override
    public void run() {
        try {
            URL httpUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) httpUrl.openConnection();
            conn.setConnectTimeout(5000);
            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuffer sb = new StringBuffer();

            String str;
            while ((str=reader.readLine()) != null){
                sb.append(str);
            }

            final List<Person> data = parseJson(sb.toString());
            handler.post(new Runnable() {
                @Override
                public void run() {
                    adapter.setData(data);
                    listView.setAdapter(adapter);
                }
            });


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private List<Person> parseJson(String json){
        try {
            JSONObject object = new JSONObject(json);
            List<Person> persons = new ArrayList<Person>();
            int resutl = object.getInt("result");
            if(resutl == 1){
                JSONArray personData = object.getJSONArray("personData");

                for (int i = 0; i < personData.length(); i++) {
                    Person personObject = new Person();
                    persons.add(personObject);
                    JSONObject person = personData.getJSONObject(i);
                    String name = person.getString("name");
                    int age = person.getInt("age");
                    String url = person.getString("url");
                    personObject.setName(name);
                    personObject.setAge(age);
                    personObject.setUrl(url);
                    JSONArray schoolInfos = person.getJSONArray("schoolInfo");

                    List<SchoolInfo> schinfos = new ArrayList<SchoolInfo>();
                    personObject.setSchoolInfo(schinfos);

                    for (int j = 0; j < schoolInfos.length(); j++) {
                        JSONObject school = schoolInfos.getJSONObject(j);
                        String schoolName = school.getString("school_name");

                        SchoolInfo info = new SchoolInfo();
                        info.setSchool_name(schoolName);
                        schinfos.add(info);
                    }
                }
                return persons;
            }else {
                Toast.makeText(context,"error",1).show();
            }

        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}
