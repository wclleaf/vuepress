---
title: b、strong和em、标签的区别
date: 2024-06-09 09:33:18
permalink: /pages/2c07cc/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
`b`、`strong`和`em`标签都表示对文本的强调，但它们在表现和实际用途有所不同

#### b标签
仅对文本加粗处理，没有其它任何意义，在浏览器默认样式中表现为：
```scss
b {
  font-weight: bold;
}
```


#### strong标签
样式表现为文本加粗，浏览器默认样式也同`b`标签。但加粗并不是该标签的主用作用，`strong`标签通常用于对文本内容的强调和标记一些重要的信息，同时搜索引擎也会对该标签内容进行提取。
同时针对视障人士的屏幕阅读器也会对改标签内容进行强调
```css
strong {
  font-weight: bold;
}
```


#### i标签
仅用于显示文本为斜体，没有其它任何意义，在浏览器表现为：
```css
i {
  font-style: italic;
}
```


#### em标签
样式表现为文本斜体，浏览器默认样式同`i`标签。但斜体也不是该标签的主要作用，`em`标签通常用于对文本内容的强调，与`strong`的强调不同它是在语气或语义有所加强，在屏幕阅读器上表现为不同的语气和语调。同时搜索引擎优化也会对该内容进行提取。
```css
em {
  font-style: italic;
}
```