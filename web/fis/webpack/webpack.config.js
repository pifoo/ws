var webpack = require('webpack')
module.exports = {
    entry: {
            index: './src/index.js',
            //a: './src/a.js'
        },
    output: {
        path: './dist/',
        filename: '[name].js',
        publicPath: '/dist',        // 代码监控  // webpack-dev-server 启动目录是  `/`, `/dist` 目录是打包的目标目录相对于启动目录的路径
    },
    module: {
        loaders: [{
            test: /\.js$/,
            exclude: /node_modules/,
            loader: 'babel',
            query: {
                presets: ['es2015', 'stage-0', 'react']
            },
            //  resolve 和 resolveLoader 参数来设置模块解析的处理细节，resolve 用来配置应用层的模块（要被打包的模块）解析，resolveLoader 用来配置 loader 模块的解析
            // resolve: { fallback: path.join(__dirname, "node_modules") },
            // resolveLoader: { fallback: path.join(__dirname, "node_modules") }
        }]
    },
    plugins: [
        new webpack.BannerPlugin('This file is created by pifoo')
    ]

}
