---
title: unity 动态设置图片border（九宫格）
date: 2020-11-11 18:29:12
permalink: /pages/258707/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---

####  我们一般是在编辑器里打开Sprite Editor设置图片的border，border用vector4表示为：Vector4(right, top, left, bottom)。但在程序运行过程中border就固定了，如果我们想修改Border可以使用unity里面提供一个方法==Sprite.Create==

```c#
//Sprite提供一个静态的方法构建sprite的时候重置border（最后一个参数）
public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, [DefaultValue("100.0f")] float pixelsPerUnit, [DefaultValue("0")] uint extrude, [DefaultValue("SpriteMeshType.Tight")] SpriteMeshType meshType, [DefaultValue("Vector4.zero")] Vector4 border);
Image ImgBG = GetComponent<Image>();
//boder可以是来自图片的border或自定义Vector4
Vector4 border = ImgBG.sprite.border
// texture 转 sprite
Sprite sp = Sprite.Create(
    tex, 
    new Rect(0, 0, tex.width, tex.height), 
    Vector2.zero, 100.0f, 0,
    SpriteMeshType.Tight,
    border/*重置border保证图片被正常slice*/);

//sprite
Sprite sp = Sprite.Create(
	sprites.texture,/*sprite里面自带图集*/
    new Rect(0, 0, tex.width, tex.height), 
    Vector2.zero, 100.0f, 0,
    SpriteMeshType.Tight,
    border/*重置border保证图片被正常slice*/);
)


```



