---
title: all保证多个异步操作同步进行
date: 2023-05-05 15:45:46
permalink: /pages/679dd7/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
在编写程序时我们可能会遇到这样一种情况：有多个异步p1、p2、p3...同时进行且互不相关，在多个异步操作都结束后再执行后续代码。我们为了保证同步操作，通常会使用下面的方式：

```js
// 方式一：使用异步回调
promise1.then(res1 => {
	promise2.then(res2 => {
		// do something
	})
})
// 方式二： 使用async/await
let res1 = await promise1
let res2 = await promise2
// ...
// do something
```

使用上面两种方式都会造成时间上的浪费，使用的时间为`t1 + t2`，而使用`Promise.all`可以让多个异步操作同时进行并且保证最长时间为`Math.max(t1, t2)`
如下：传入参数为异步操作数据，`resolve`结果为所有操作合集
```js
Promise.all([promise1, promise2,...]).then(values => {
	// values: [res1, res2, res3]
})
```

详细使用请查看[官方文档](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise/all)

