## 1. react 特点
> 概念:
    一个用于创建 可复用、可聚合 的web组件的js库；
    只提供前端 MVC 中的 V 层；

- 1.1 组件化
- 1.2 单向数据流
- 1.3 虚拟DOM树

## 环境准备
- 1.1 安装npm (npm init & package.json-> 配置browser-sync)
- 1.2 安装bower(包管理器)
- 1.3 mkdir react_tuts & cd react_tuts
- 1.4 bower install react
- 1.5 touch index.html
- 1.6 引入库文件
```
<script src="./bower_components/react/react.min.js"></script>
<script src="./bower_components/react/react-dom.min.js"></script>
// JSX 转成标准的 JavaScript
<script src="./babel-core/browser.5.8.23.min.js"></script>
```
- 1.7 书写代码
```
<div id="app"></div>
<script type="text/babel">
    ReactDOM.render(
    <h1>Hello, world!</h1>, document.getElementById('app') );
</script>
```
