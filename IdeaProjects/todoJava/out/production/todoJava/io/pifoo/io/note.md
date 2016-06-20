
# File类的使用
---
>- java.io.File类用于表示文件(目录)    
- File类只用于表示文件(目录)的信息(名称,大小等),不能用于文件内容的访问     

# RandomAccessFile 
---
>- RandomAccessFile java提供对文件内容的访问,即可以读文件、又可以写文件.    
- RandomAccessFile 支持随机访问文件 ,可以访问文件的任意位置.

###1) java文件模型    
- 在硬盘上的文件是byte byte byte存储的,是数据的集合              

###2) 打开文件    
   - 有两模式"rw"(读写) 和 "r"(读)    
   - RandomAccessFile raf = new RandomAccessFile(file,"rw");    
   - 文件指针,打开文件时指针在开头 pointer = 0;    

###3) 写方法    
   - raf.write(int) -> 只写一个字节(后8位),同时指针指向下一个位置,准备再次写入;    

###4) 读方法    
   - int b = raf.read() -> 读一个字节        

###5) 文件读写完成以后一定要关闭raf.close();           

# IO流(输入流、输出流)         
---
## 1. 字节流    

###1) InputStream, OutputStream        
   - InputStream抽象了应用程序读取数据的方式 
   - OutputStream抽象了应用程序写出数据的方式    

###2) EOF = end    读到 -1 就读到结尾     

###3) 输入流基本方法      
   - int b = in.read(); 读取一个字节无符号填充到int低8位,-1是EOF    
   - in.read(byte[] buf); 读取数据填充到字节数据buf     
   - in.read(byte[] buf,int start,int size); 读取数据到字节数组buf,从buf的start位置开始,存放size长度的数据     

###4) 输出流基本方法     
   - out.write(int b); 写出一个byte到流,b的低8位 
   - out.write(byte[] buf); 将buf字节数组都写入到流    
   - out.write(byte[] buf,int start,int size); 字节数组buf从start位置开始写入size长度的字节到流  
      
###5) FileInputStream -> 具体实现了在文件上读取数据     

###6) FileOutputStream -> 实现了向文件中写出byte数据的方法  

###7) DataOutputStream & DataInputStream        
   - 对"流"功能的扩展，可以更加方便地读取int,long,字符等类型数据      
   -  DataOutputStream -> 常用方法：        
     writeInt()/writeDouble()/writeUTF()    

###8) BufferedInputStream & BufferedOutputStream       
   - 这两个流类为IO提供了带缓冲区的操作,一般打开文件进入写入、读取操作时,都会加上缓冲,这种流模式提高了IO的性能;     
   - 从应用程序中把输入放入文件,相当于将一缸水倒入另一个缸中:      
   - FileOutputStream -> write()方法相当于一滴一滴的把水"转移"过去;         
   - DataOutputStream -> writeXxx()方法会方便一些,相当于一瓢一瓢的把水"转移"过去;           
   - BufferedInputStream -> write()方法更方便,相当于先一瓢一瓢的把水放入桶中(缓冲区),再从桶中倒入到另一人缸中,性能提高了.       
   

## 2. 字符流     
###1)  理解编码问题

###2) 认识文本和文本文件
   - java的文本(char)是16位无符号整数,是字符的unicode编码(双字节);    
   - 文件是byte byte byte...的数据序列;    
   - 文本文件是文本(char)序列按照某种编码方案(utf-8,utf-16be,gbk)序列化为byte的存储结构;  
   
###3) 字符流(Reader & Writer)  -> 操作的是文本文件        
   >- 字符的处理,一次处理一个字符      
- 字符的低层仍然是基本的字节序列      

   字符流的基本实现    
   - InputStreamReader  完成byte流角析为char流,按照编码解析        
   - OutputStreamWriter  提供char流到byte流,按照编码解析     

###4) FileReader & FileWriter























