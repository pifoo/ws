var request = require('request')
var url = 'http://www.163.com'

request(url, function (err, res, body) {
    console.log(body)
})
