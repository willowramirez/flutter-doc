<!--
 * @LastEditors: Tao Yang
 * @Description: 暂无描述
 * @FilePath: /flutter-doc/build.md
 * @Date: 2025-06-30 19:35:06
 * @LastEditTime: 2025-10-20 18:09:26
 * @Author: Tao Yang
-->

# 构建 APK

[toc]

## 命令行

```bash
flutter build apk --release \
  --build-name=x.y.z \
  --build-number=1 \
  --dart-define=API_URL=http://192.168.42.1:8081
```

- `--build-name`：应用版本号
- `--build-number`：应用构建号
- `--dart-define`：定义 Dart 变量
  - `API_URL`：API 地址

## 构建产物

`build/app/outputs/apk/release/bar-monitor-config_cn.smyze.monitorconfig_1.1.1.apk`
