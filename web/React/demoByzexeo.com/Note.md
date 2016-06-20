## 1. react 特点
> 概念:
    一个用于创建 可复用、可聚合 的web组件的js库；
    只提供前端 MVC 中的 V 层；

- 1.1 组件化
- 1.2 单向数据流
- 1.3 虚拟DOM树

## 环境准备
- 1.1 mkdir react_tuts & cd react_tuts
- 1.2 安装npm (npm init & package.json-> 配置browser-sync)
- 1.3 touch index.html
- 1.4 引入库文件
```
<script type="text/javascript" src="./dist/react.js"></script>
<script type="text/javascript" src="./dist/JSXTransformer.js"></script>
```
- 1.7 书写代码
```
<div id="app"></div>
<script type="text/jsx">
    // 0. 生成组件并渲染到页面
    React.render(
        <h1>Hello, world!</h1>,
        //React.createElement('h2', null, 'Hello, world!'),
        document.getElementById('hello')
    );   
</script>
```
[初识react](http://zexeo.com/course/56753a22b2b8de861c0d281a)
[rudux](http://zexeo.com/course/5672c2bd52b470c02bc28b6c)
[angular-ui-awesome](http://eisneim.github.io/angular-ui-awesome)
>- 1.0 初识React
- 2.0 第一个组件hellow world
- 3.0 组件的嵌套
- 4.0 组件的状态state
- 5.0 组件的参数props
- 6.0 事件events
- 7.0 指向ref
- 8.0 双向数据流
- 9.0 组件生命周期
- 10.0 mixin
- 11.1 开发环境和工具
- 11.2 分成小组件
- 11.3 添加功能
- 12.0 结尾
