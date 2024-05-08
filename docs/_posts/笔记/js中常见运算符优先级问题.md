---
title: js中点运算符优先级
date: 2023-02-08 16:06:01
permalink: /pages/ffb814/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
#### 点运算符
点运算符`.`会优先视为数字常亮的一部分，其次才是对象访问符，比如说`3.`、`.3`都是正常的数值
```js
3.toString() // 优先识别数字3. 会报语法错误，
let num = 3
num.toString() // 结果为'3'，不要使用常亮数值转字符串
3..toString() // 结果为'3', 第一个点为数值3.，第二个点为对象访问符
```
