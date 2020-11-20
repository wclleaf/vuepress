## 基于vuepress博客文档

使用前请先安装依赖包
```sh
npm install // yarn add
```

在theme-vdoing主题的基础上集成了看板娘。模型存放在本地`docs/.vuepress/public/live2d`，如果需要更换

修改`deploy.sh`中git地址，这里使用的是阿里Codeup的流水线自动部署。具体步骤请看我的另一篇文章[02.阿里云效Codeup流水线自动部署](https://doc.chenglin.online/pages/c79ced/)
```sh
git init
git add -A
git commit -m "部署更新"
git push -f 你的git地址 master
# 触发部署流水线
# curl --header "Content-Type: application/json" --request POST --data '{}' 你的Webhook触发地址 
```


参考：
[vdoing主题](https://github.com/xugaoyi/vuepress-theme-vdoing)
[vue 看板娘](https://github.com/evgo2017/vue-live2d)
[每日一言](https://hitokoto.cn/)
[ACG图片](https://www.alapi.cn/doc/show/20.html)