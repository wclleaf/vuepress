#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# push to blog
git add -A
git commit -m "代码更新"
# git push -f https://codeup.aliyun.com/kros/ll_lin/theme-vdoing-blog.git master
git push -f https://gitee.com/wclcc/vuepres-blog.git master

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to codeup
git init
git add -A
git commit -m "部署更新"
# git push -f https://codeup.aliyun.com/kros/ll_lin/deploy-test.git master
git push -f https://gitee.com/wclcc/deploy-codeup.git master
curl --header "Content-Type: application/json" --request POST --data '{}' http://flow-openapi.aliyun.com/pipeline/webhook/7sUxOuMAPSoor7acp4gE  # 触发部署流水线


cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist