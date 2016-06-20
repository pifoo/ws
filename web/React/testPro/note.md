
# 1.0 环境准备

```
➜  react git:(master) ✗ mkdir testPro     // 生成工程目录
➜  react git:(master) ✗ cd testPro
➜  testPro git:(master) ✗ npm init        // 初始化，生成工程package.json
➜  ~ npm install -g browser-sync          // 全局安装  site: browsersync.io
➜  testPro git:(master) ✗ npm install --save browser-sync   // 安装在工程目录下(已全局安装，可免此操作)
```

## 1.1 编辑 package.json, 添加：
```
	"scripts": {
		"dev": "browser-sync start --server --files \"*.*\""   // 监听文件刷新
	},
	"dependencies": {
		"browser-sync": "^2.12.8"
	}
```

## 1.2 运行browser-sync server, 监听文件刷新
```
➜  testPro git:(master) ✗ npm run dev					   // 运行自定义的 dev 命令脚本
➜  testPro git:(master) ✗ touch index.html				   // 创建html文件
```
