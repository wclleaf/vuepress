---
title: 不使用overflow进行内容裁剪
date: 2023-05-08 11:56:44
permalink: /pages/b3ccf4/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
今天搬砖时突然有个想法：如何不使用`overfolw`来实现内容裁剪，`overflow`相信大家使用都和熟练了，我们通常使用它来设置溢出元素的行为，详细使用见[MDN-overflow](https://developer.mozilla.org/zh-CN/docs/Web/CSS/overflow)
但如果不使用`overflow`还要进行裁剪我第一时间想到的就是：`clip-path`万能的裁剪属性
使用
```scss
.clip {
	clip-path: polygon(0 0, 100% 0, 100% 100%, 0 100%);
}
```
