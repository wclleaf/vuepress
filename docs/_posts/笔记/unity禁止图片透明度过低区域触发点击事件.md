---
title: unity禁止图片透明度过低区域触发点击事件
date: 2020-10-31 21:58:23
permalink: /pages/9e9a2c/
sidebar: auto
categories:
  - 随笔
tags:
  - unity
---
游戏中的每张图都是方块，图片可能存在很多透明或alpha值很低区域，如果我们只想点击事件触发在有颜色值得地方就可以使用image的alphaHitTestMinimumThreshold属性。代码如下：

```csharp
Image img = transform.GetComponent<Image>();
//低于设置值0.2以下的alpha不能触发点击事件
img.alphaHitTestMinimumThreshold = 0.2f;
```