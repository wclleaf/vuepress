---
title: c#位域
date: 2020-11-19 16:06:26
permalink: /pages/3b9899/
sidebar: auto
categories:
  - 随笔
tags:
  - c#
---
`[System.Flags]` //位域 s使数据能进行位运算，通常用于权限的控制

```csharp
[System.Flags]
enum Permission
{
	Create = 1, //0x0001
	Read = 2,   //0x0010
	Write = 4,  //0x0100
	Delete = 8, //0x1000
}
Permission p = Permission.Create | Permission.Write | Permission.Read;
p.ToString();//所有的枚举 Create,Write,Read
(int)p;//7
Permission style = (Permission) Enum.Parse(typeof(Styles), (int)p );//获取数组对应的枚举
```
