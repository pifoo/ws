https://segmentfault.com/a/1190000005612506
http://www.infoq.com/cn/articles/react-and-webpack
http://zhaoda.net/webpack-handbook
https://fakefish.github.io/react-webpack-cookbook/index.html

## 工具安装
```
➜  npm install webpack -g

```

## 工程准备
.
├── index.html      // 入口 HTML  
├── dist            // dist 目录放置编译过后的文件文件
└── src             // src 目录放置源文件
    └── index.js    // 入口 js

```
➜  npm init
➜  webpack git:(master) ✗ npm install webpack --save-dev
```

## 使用
```
$ webpack src/index.js dist/index.js
```
配置脚本
```
var webpack = require('webpack')
module.exports = {
  entry: './src/index.js',
  output: {
    path: './dist/',
    filename: 'index.js'
  }
}
```
执行
```
➜  webpack git:(master) ✗ webpack
```
webpack 支持 Jsx
```
// babel 相关的模块
$ npm install babel-loader babel-preset-es2015 babel-preset-stage-0 babel-preset-react babel-polyfill --save-dev

// react 相关的模块
$ npm install react react-dom --save
```

启动服务,实时监听
```
➜  webpack git:(master) ✗ webpack-dev-server --content-base ./
```

加载css模块
```
➜  webpack git:(master) ✗ npm install css-loader style-loader --save-dev
```

通过参数让编译的输出内容带有进度和颜色
```
$ webpack --progress --colors
```

启动监听模式
```
$ webpack --progress --colors --watch
```

dug
```
$ webpack --display-error-details
```
