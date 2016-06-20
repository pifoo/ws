package io.pifoo.dom4j;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * Created by pifoo on 15/12/1.
 */
public class Dom4jDemo1 {
    public static void main(String[] args) throws DocumentException {
        // 1. 获取解析器
        SAXReader reader = new SAXReader();
        // 2. 解析XML 获取代表整个文档的dom对象
        Document dom = reader.read("XMLParse/book.xml");
        // 3. 获取根节点
        Element root = dom.getRootElement();
        // 4. 遍历节点获取内容
        Element title = root.element("book").element("title");
        String bookName = title.getText();

        System.out.println(bookName);

    }
}
