// 1. 创建一个 Http Server
var http = require('http');
http.createServer(function (request, response) {
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');

console.log(__dirname + '\n', __filename);

// 2. Buffers 缓存对象
// e.g 将一个utf8字符串写入buffer，然后打印出来
buf = new Buffer(256); // 创建指定大小的buffer 对象
len = buf.write('\u00bd + \u00bc = \u00be', 0);
console.log(len + " bytes: " + buf.toString('utf8', 0, len));

// 3.
require('sys').print('String with no newline');
