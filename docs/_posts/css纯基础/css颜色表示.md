---
title: css颜色表示
date: 2024-04-22 21:48:48
permalink: /pages/00b8bf/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
#### 关键字
css中提供了如：`white`、`red`、`blue`等一系列预定义的颜色



#### rgb
使用`rgb()`来表示颜色。rgb传递三个参数0~255或0%~100%，三个参数分别表示红、绿、蓝的颜色的亮度
```scss
.color {
  color: rgb(255, 0, 0); // 红色
  color: rgb(255, 255, 0); // 黄色
}
```

#### rgba
`rgba`相对`rgb`多了个透明度参数。rgba传递四个参数：红色（Red）、绿色（Green）、蓝色（Blue）和 Alpha 通道（透明度），颜色参数范围为0~255或0%~100%，而Alpha的取值范围为0~1
```scss
.color {
  color: rgb(255, 0, 0, .5); // 淡红色
}
```


#### 十六进制
css使用最多的颜色标识方式就是十六进制方式，`rga`和`rgba`都可以用十六进制的方式表示。将`rgba`的四位参数分别转为两位的十六进制即可，最后的透明度默认为`ff`也就是`rgba`中Alpha为1。
```scss
.color {
  color: #ff0000; // 红色 相当于rgb(255, 0, 0, 1) ，默认的透明度为ff所以也可以写为#ff0000ff
  color: #ff000080; // 淡红色 相当于rgb(255, 0, 0, .5)
}
```
十六进制在某些情况下也可以缩写，比如`#ff0000`可以缩写为`#f00`、`#aa1177`可以缩写为`#a17`。每种的颜色值个位和十位是一样就可以缩写，为了统一和避免出现问题代码中尽量不进行缩写。


#### hsl
HSL代表色相(Hue)、饱和度(Saturation)、亮度(Lightness)。色相是颜色在色轮上的位置，以度为单位；饱和度表示颜色的纯度，范围从0%（灰色）到100%（完全饱和）；亮度表示颜色的明暗程度，也是0%到100%的范围。

以下依次为：色相、饱和度、亮度
::: center
![色相](https://lhost.oss-cn-chengdu.aliyuncs.com/blog/20240423160943.png)
![饱和度](https://lhost.oss-cn-chengdu.aliyuncs.com/blog/20240423161248.png)
![亮度](https://lhost.oss-cn-chengdu.aliyuncs.com/blog/20240423161310.png)
:::

这种一般是设计人员在设计图上会使用，在程序一般不会用


这里只介绍的上面几种表示方式但颜色值的表示方式远远不止这几种，我们随便点击浏览器控制台中的颜色值都可以看到许多陌生的颜色值表示方式。我们在程序中使用到的无非就是上述几种，其它的知道有这个东西就行了。（手动笑脸）
::: center
![颜色](https://lhost.oss-cn-chengdu.aliyuncs.com/blog/20240423161603.png)
:::