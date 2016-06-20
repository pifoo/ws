

// 转码前
[1,2,3].map(n => console.log(n + 1));


// 转码后
[1, 2, 3].map(function(n) {
    return console.log(n + 1);
});
