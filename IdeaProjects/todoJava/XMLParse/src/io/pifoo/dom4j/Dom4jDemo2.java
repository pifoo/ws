package io.pifoo.dom4j;

import org.dom4j.*;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.junit.Test;

import java.io.*;
import java.util.List;

/**
 * Created by pifoo on 15/12/1.
 */
public class Dom4jDemo2 {
    @Test
    public void attr() throws DocumentException, IOException {
        SAXReader reader = new SAXReader();
        Document dom = reader.read("book.xml");
        Element root = dom.getRootElement();

        Element bookEle = root.element("book");
        bookEle.addAttribute("press","turing");

        System.out.println(bookEle.attributeValue("press"));

        Attribute attr = bookEle.attribute("press");
        attr.getParent().remove(attr);

        XMLWriter writer = new XMLWriter(new FileOutputStream("book.xml"),OutputFormat.createPrettyPrint());
        writer.write(dom);
        writer.close();
    }

    @Test
    public void del() throws DocumentException, IOException {
        SAXReader reader = new SAXReader();
        Document dom = reader.read("book.xml");
        Element root = dom.getRootElement();

        Element price2Ele = root.element("book").element("price2");
        price2Ele.getParent().remove(price2Ele);

        XMLWriter writer = new XMLWriter(new FileOutputStream("book.xml"),OutputFormat.createPrettyPrint());
        writer.write(dom);
        writer.close();
    }

    @Test
    public void update() throws DocumentException, IOException {
        SAXReader reader = new SAXReader();
        Document dom = reader.read("book.xml");
        Element root = dom.getRootElement();

        root.element("book").element("price2").setText("4.00元");

        XMLWriter writer = new XMLWriter(new FileOutputStream("book.xml"),OutputFormat.createPrettyPrint());
        writer.write(dom);
        writer.close();
    }


    @Test
    public void add() throws DocumentException, IOException {
        SAXReader reader = new SAXReader();
        Document dom = reader.read("book.xml");
        Element root = dom.getRootElement();

        // 1. 凭空创建<price2>节点,设置标签体
        Element price2Ele = DocumentHelper.createElement("price2");
        price2Ele.setText("40.00元");
        // 2. 获取父标签<book>,将<SpecialOffer>挂载上去
        Element bookEle = root.element("book");
        bookEle.add(price2Ele);

        // 3. 将内存中的dom树回写到xml文件中,从页使xml中的数据进行更新

        // 3.1 方案一
        /*FileWriter writer = new FileWriter("book.xml");
        dom.write(writer);
        writer.flush();
        writer.close();*/

        // 3.2 方案二
        XMLWriter writer = new XMLWriter(new FileWriter("book.xml"),OutputFormat.createPrettyPrint());
        writer.write(dom);
        writer.close();

    }

    @Test
    public void find() throws DocumentException {
        SAXReader reader = new SAXReader();
        Document dom = reader.read("book.xml");
        Element root = dom.getRootElement();

        List<Element> list = root.elements();
        Element book2Ele = list.get(1);
        System.out.println(book2Ele.element("title").getText());
    }

}