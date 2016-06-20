package io.pifoo.sax;

import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;

/**
 * SAX 解析为逐行扫描并解相应方法
 * Created by pifoo on 15/12/1.
 */
public class SaxDemo1 {
    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
        // 1. 获取解析工厂
        SAXParserFactory factory = SAXParserFactory.newInstance();
        // 2. 通过工厂获取sax解析器
        SAXParser parser = factory.newSAXParser();
        // 3. 获取读取器
        XMLReader reader = parser.getXMLReader();

        // 4. 注册事件处理器(自己实现)
        //reader.setContentHandler(new myContentHandler());
        reader.setContentHandler(new myContentHandler2());

        // 5. 解析xml
        reader.parse("XMLParse/book.xml");
    }

}

//  打印第二本书的内容
class myContentHandler2 extends DefaultHandler{ // 适配器设计模式
    private String eleName = null;
    private int count = 0;

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        super.startElement(uri, localName, qName, attributes);
        this.eleName = qName;
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        super.endElement(uri, localName, qName);
        this.eleName = null;//不打印换行符等
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        super.characters(ch, start, length);
        if("title".equals(eleName) && ++count==2){
            System.out.println(new String(ch,start,length));
        }
    }
}

// 打印整个文档
class myContentHandler implements ContentHandler{

    @Override
    public void setDocumentLocator(Locator locator) {

    }

    @Override
    public void startDocument() throws SAXException {
        System.out.println("文档解析开始……");

    }

    @Override
    public void endDocument() throws SAXException {
        System.out.println("文档解析结束");
    }

    @Override
    public void startPrefixMapping(String prefix, String uri) throws SAXException {

    }

    @Override
    public void endPrefixMapping(String prefix) throws SAXException {

    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException {
        System.out.println("发现开始标签:" + qName);
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        System.out.println("发现结束标签:" + qName);
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        System.out.println(new String(ch,start,length));
    }

    @Override
    public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {

    }

    @Override
    public void processingInstruction(String target, String data) throws SAXException {

    }

    @Override
    public void skippedEntity(String name) throws SAXException {

    }
}
