JAVA的容器---List,Map,Set 
Collection                > 存放独立元素的序列
├ List 接口                     > Collection定义了Collection类型数据的最基本、最共性的功能接口，而List对该接口进行了拓展
│├ LinkedList 链表              > * 其数据结构采用的是链表，此种结构的优势是删除和添加的效率很高，但随机访问元素时效率较ArrayList类低
│├ ArrayList 数序结构动态数据类   > * 其数据结构采用的是线性表，此种结构的优势是访问和查询十分方便，但添加和删除的时候效率很低
│└ Vector  向量               > 
│　└ Stack 栈
└ Set                     > Set类不允许其中存在重复的元素(集)
│　└ HashSet             > * HashSet利用Hash函数进行了查询效率上的优化，其contain（）方法经常被使用，以用于判断相关元素是否已经被添加过
│　└ TreeSet 
│　└ LinkedHashSet
Map                       > 存放key-value型的元素对
├ Hashtable 
├ HashMap                 > * 
├ WeakHashMap
├ WeakHashMap
├ IdentityHashMap