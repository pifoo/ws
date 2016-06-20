## npm --help
```
sudo npm update -g npm          // 更新npm
npm install <name> -g           // 全局环境
npm install <name> --save       // -save 本地安装（工程目录下），安装的同时将信息写入package.json
npm install <name> --save-dev   // -save-dev 部署在开发环境，自动更新package.json
npm install                     // 根据package.json dependencies配置安装所有的依赖包
```

## yeoman & grunt/gulp & bower 组合用法
```
npm install -g yo grunt-cli bower           // 安装
yo --help

npm install -g[--save] generator-webapp         // 安装webapp生成器
yo webapp   // 构建webapp工程
[npm install & bower install]               // 根据package.json安装依赖

bower list  // 命令查看项目依赖

grunt test/gulp test ?               // 执行单元测试
gulp build
gulp serve

yo webapp --help
yo doctor

```


## 引申
>
 TDD   Test Drive Development (测试驱动开发)    
 BDD   Behavior Drive Development（行为驱动开发）      
 DDD   Domain Drive Design（领域驱动开发）
