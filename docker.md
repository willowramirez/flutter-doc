# Docker

## 登陆阿里云docker

`docker login --username=357947287@qq.com crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com`

## 构建镜像【--no-cache】

`docker build . --platform linux/amd64,linux/arm64 -t screen`

## 打标签

`docker tag screen crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com/willowramirez/screen:0.0.1`

## 推送镜像

`docker push crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com/willowramirez/screen:0.0.1`

## 登陆设备

`ssh smyze@192.168.42.1`

## 下载镜像（可选）

`docker pull crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com/willowramirez/screen:0.0.1`


## 启动容器

```bash
# 远端设备
docker run -d --name screen -p 8080:80 -v /home/smyze/data/video:/usr/share/nginx/html/videos crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com/willowramirez/screen:0.0.1

# 本地设备
docker run -d --name screen -p 8080:80 -v /Users/willowramirez/SMYZE/video:/usr/share/nginx/html/videos crpi-h130euqdn1loewqy.cn-hangzhou.personal.cr.aliyuncs.com/willowramirez/screen:0.0.1
```

## 打开页面

`nohup /snap/bin/chromium --kiosk --incognito --disable-pinch --overscroll-history-navigation=0 --window-position=1,1 --start-fullscreen http://localhost:8080 &`

## 设备WIFI

```text
smyze_bar_wifi#C004

segx#!3hv09ka@fje3
```

### 上传到公司镜像服务

```bash
docker build . --platform linux/amd64,linux/arm64 -t bar-tv-web-app
docker tag bar-tv-web-app registry.cn-shanghai.aliyuncs.com/smyze/bar-tv-web-app:0.0.1
docker push registry.cn-shanghai.aliyuncs.com/smyze/bar-tv-web-app:0.0.1
```
