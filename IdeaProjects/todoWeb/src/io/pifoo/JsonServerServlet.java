package io.pifoo;


import com.google.gson.Gson;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pifoo on 15/12/7.
 *
 */
// TODO
public class JsonServerServlet extends HttpServlet {
    //private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        this.doPost(request,response);
    }

    @Override
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        //this.doGet(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();



        Result result = new Result();
        result.setResult(1);
        List<Person> list = new ArrayList<Person>() ;
        result.setPersonData(list);

        //构造person1的数据
        Person person1 = new Person();
        person1.setName("pifoo");
        person1.setAge(30);
        person1.setUrl("http://img0.imgtn.bdimg.com/it/u=2880877329,652700037&fm=21&gp=0.jpg");

        List<SchoolInfo> schools = new ArrayList<SchoolInfo>();
        SchoolInfo schoolInfo1 = new SchoolInfo();
        schoolInfo1.setSchool_name("清华");
        SchoolInfo schoolInfo2 = new SchoolInfo();
        schoolInfo2.setSchool_name("北大");
        schools.add(schoolInfo1);
        schools.add(schoolInfo2);

        person1.setSchoolInfo(schools);

        list.add(person1);

        //构造person2的数据
        Person person2 = new Person();
        person2.setName("jack");
        person2.setAge(35);
        person2.setUrl("http://img5.imgtn.bdimg.com/it/u=2532484842,2032258749&fm=21&gp=0.jpg");

        List<SchoolInfo> schools1 = new ArrayList<SchoolInfo>();
        SchoolInfo schoolInfo3 = new SchoolInfo();
        schoolInfo3.setSchool_name("交大");
        SchoolInfo schoolInfo4 = new SchoolInfo();
        schoolInfo4.setSchool_name("北航");
        schools1.add(schoolInfo3);
        schools1.add(schoolInfo4);

        person2.setSchoolInfo(schools1);

        list.add(person2);


        Gson gson = new Gson();
        System.out.println(gson.toJson(result));

        out.print(gson.toJson(result)); //将josn数据返回给客户端

    }
}
