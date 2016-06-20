
# 文献：
---
### ES6   

- http://es6.ruanyifeng.com/

### 支持能力

- http://kangax.github.io/compat-table/es6/
- https://github.com/paulmillr/es6-shim

### 运行环境

- https://github.com/creationix/nvm
- https://nodejs.org/en/
- https://www.npmjs.com/

### 特性检测

1. 查看Node所有已经实现的ES6特性
~~~
    ➜  ~ node --v8-options | grep harmony
~~~
2. 检查各种运行环境对ES6的支持情况
   [es-checker](http://ruanyf.github.io/es-checker/)  
~~~
    ➜  ~ npm install -g es-checker
~~~
3. 查看本机支持ES6的程度
~~~
    ➜  ~ es-checker
~~~

### Babel转码器

   + [babel 官网](https://babeljs.io/)
   + [Babel 用户手册](https://github.com/thejameskyle/babel-handbook/blob/master/translations/zh-Hans/user-handbook.md)

1. 工程初始化
~~~
    ➜  ES6 git:(master) ✗ npm init   
~~~
2. 本地安装
~~~
    ➜  ES6 git:(master) ✗ npm install --save-dev babel-cli (建议安装在当前工程目录,非全局)
/*
➜  ~ npm install -g babel-cli  
     npm uninstall --global babel-cli
     */
~~~
3. 转码前后(ES6->ES5)
~~~
    //转码前
    [1,2,3].map(n => console.log(n + 1));

    //转码后
    [1, 2, 3].map(function(n) {
        return console.log(n + 1);
    });
~~~
4. 配置文件.babelrc    
Babel的配置文件是.babelrc，存放在项目的根目录下(使用Babel的第一步，就是配置这个文件);
   创建 .babelrc
~~~
    ➜  ES6 git:(master) ✗ touch .babelrc
~~~
   .babelrc该文件用来设置转码规则和插件，基本格式如下:
~~~
    {
        "presets": [],
        "plugins": []
    }
~~~
5. 为presets字段设定转码规则(语法集)，官方提供以下的规则集，可以根据需要安装  
   ES6转码规则
~~~
    $ npm install --save-dev babel-preset-es2015
~~~
   react转码规则
~~~
    $ npm install --save-dev babel-preset-react
~~~
   ES7不同阶段语法提案的转码规则（共有4个阶段），选装一个
~~~
    $ npm install --save-dev babel-preset-stage-0
    $ npm install --save-dev babel-preset-stage-1
    $ npm install --save-dev babel-preset-stage-2
    $ npm install --save-dev babel-preset-stage-3
~~~
6. 安装转码规则集
~~~
➜  ES6 git:(master) ✗ npm install --save-dev babel-preset-es2015
➜  ES6 git:(master) ✗ npm install --save-dev babel-preset-react
➜  ES6 git:(master) ✗ npm install --save-dev babel-preset-stage-3
~~~
7. 然后，将这些规则加入.babelrc
~~~
    {
        "presets": [
            "es2015",
            "react",
            "stage-3"
        ],
        "plugins": []
    }
~~~
8. babel基本用法
~~~
    转码结果输出到标准输出
    $ babel example.js

    转码结果写入一个文件 (--out-file 或 -o 参数指定输出文件)
    $ babel example.js --out-file compiled.js
    或者
    $ babel example.js -o compiled.js

    整个目录转码 (--out-dir 或 -d 参数指定输出目录)
    $ babel src --out-dir lib
    或者
    $ babel src -d lib

    -s 参数生成source map文件
    $ babel src -d lib -s
~~~

### package.json配置

1. 工程初始化,生成 package.json
~~~
    ➜  ES6 git:(master) ✗ npm init   
~~~
2. 改写package.json  
~~~
    "devDependencies": {
        "babel-cli":"^6.6.5",
        "babel-preset-es2015": "^6.9.0",
        "babel-preset-react": "^6.5.0",
        "babel-preset-stage-3": "^6.5.0"
    },
    "scripts": {
        "build": "babel src -d lib"  //将指定目录转码
    },
~~~
3. 转码执行以下命令
~~~
    ➜  ES6 git:(master) ✗ npm run build
~~~

### babel 之 babel-node

**babel-cli** 工具自带一个 **babel-node** 命令，提供一个支持ES6的REPL环境;
1. 它支持Node的REPL环境的所有功能，而且可以直接运行ES6代码.
~~~
    $ babel-node
    > (x => x * 2)(1)
    2
~~~
2. 直接运行脚本文件
~~~
    $ babel-node es6.js
    2
~~~
3. 执行脚本命令
更新package.json:
~~~
    "scripts": {
        "build": "babel src -d lib",
        "script": "babel-node *.js"
    },
~~~
执行命令
~~~
➜  ES6 git:(master) ✗ npm run script
~~~
