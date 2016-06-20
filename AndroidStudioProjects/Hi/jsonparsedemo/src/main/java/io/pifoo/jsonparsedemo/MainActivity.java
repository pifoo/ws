package io.pifoo.jsonparsedemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private Person person = new Person();
    private ArrayList<Person> persons;
    private String json1 = "[\n" +
            "    { \"id\":\"1\",\"name\":\"基神\",\"age\":\"18\" },\n" +
            "    { \"id\":\"2\",\"name\":\"B神\",\"age\":\"18\"  },\n" +
            "    { \"id\":\"3\",\"name\":\"曹神\",\"age\":\"18\" }\n" +
            "]";
    private String json2 = "{\"ch\":[" +
            "{\"names\":\"北大\",\"data\":[2,2,1,1,1,1],\"times\":[10,11,12,13,21,23]}," +
            "{\"names\":\"清华\",\"data\":[2,2,1,1,1,1],\"times\":[10,11,12,13,21,23]}" +
            "]}";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        parseEasyJson(json1);
        parseDiffJson(json2);
    }

    //解析简单josn字条串
    private void parseEasyJson(String json){
        persons = new ArrayList<Person>();
        try{
            JSONArray jsonArray = new JSONArray(json);
            for(int i = 0;i < jsonArray.length();i++){
                JSONObject jsonObject = (JSONObject) jsonArray.get(i);
                Person person = new Person();
                person.setId(i+"");
                person.setName(jsonObject.getString("name"));
                person.setAge(jsonObject.getString("age"));
                persons.add(person);

                Log.i("json1", person.toString());
            }
        }catch (Exception e){e.printStackTrace();}
    }

    //解析复杂josn字条串
    private void parseDiffJson(String json) {
        try {
            JSONObject jsonObject1 = new JSONObject(json);
            Log.d("json2", json);
            JSONArray jsonArray = jsonObject1.getJSONArray("ch");
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = (JSONObject) jsonArray.get(i);
                //取出name
                String sname = jsonObject.getString("names");
                JSONArray jarray1 = jsonObject.getJSONArray("data");
                JSONArray jarray2 = jsonObject.getJSONArray("times");
                Log.d("json2", "names->"+sname);
                Log.d("json2", "data->"+jarray1.toString());
                Log.d("json2", "times->"+jarray2.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
