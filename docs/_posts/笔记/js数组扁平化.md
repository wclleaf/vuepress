---
title: js数组扁平化
date: 2023-03-08 15:22:40
permalink: /pages/81daeb/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---

将`[1,2,3,[4,5,[6,7]],[8,9],10]`处理成`[1,2,3,4,5,6,7,8,9,10]`

#### 字符串转换
利用数组的`join`和`toString()`可以将数组包括内层数组按顺序进行拼接，默认的`toString`相当于`joing(',')`
```js
let arr = [1,2,3,[4,5,[6,7]],[8,9],10]
console.log(arr.join(',').split(',')) // [1,2,3,4,5,6,7,8,9,10]
```


#### 递归
```js
function flattenArr(arr, result = []) {
  for(let i = 0; i < arr.length; i++) {
    if (Array.isArray(arr[i])) {
      flattenArr(arr[i], result)
    } else {
      result.push(arr[i])
    }
    return reuslt
  }
}
```