---
title: race检查请求超时
date: 2021-01-05 16:27:34
permalink: /pages/af00fc/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
`Promise.race`接收一个`promise`数组，最先成功的`promise`会进入`then`或`catch`流程其它被抛弃。这里我们可以传入正常的请求和一个超时定时器，利用`Promise.race`机制断定请求是否超时

```js
function timeout1() {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve('timeout1');
		}, 1000);
	})
}

function timeout2() {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve('timeout2');
		}, 2000);
	})
}

export function testRace() {
	Promise.race([timeout1(), timeout2()]).then(res => {
		console.log(res);
	})
}
```