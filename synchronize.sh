#!/usr/bin/env sh
git pull gitee main
git add -A && git commit -am "push or fix some commit"
git push gitee
git push origin