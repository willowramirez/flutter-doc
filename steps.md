# 项目搭建

## 创建项目

Cmd+Shift+P -> Flutter: New Project -> Empty Application -> 选择目录 -> 命名项目名

## 按需更新.gitignore

## 更换图标

```bash
1. 参考：https://pub.dev/packages/flutter_launcher_icons
2. 安装插件：flutter pub add flutter_launcher_icons
3. 生成插件配置文件：dart run flutter_launcher_icons:generate
4. 配置文件内设置图片路径：image_path: "assets/images/logo.png"
5. 一键更换图标：dart run flutter_launcher_icons
```

## 更换 App 名

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
android:label="新应用名"
```

## 更换包名目录

```xml
<!-- android/app/src/main/kotlin -->
android/app/src/main/kotlin/com/xxx/yyy
```

## 设置打包配置（kts 版）

```kotlin
// android/app/build.gradle.kts
android {
  buildTypes {
    release {
      // ...
      // 在这里插入下面三行
      isMinifyEnabled = true
      isShrinkResources = true
      ndk {
        abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a"))
      }
    }
  }
}
```

## 设置构建的 apk 文件名（kts 版）

```kotlin
// android/app/build.gradle.kts
android {
  // ...
  // 在这里加入一下代码
  applicationVariants.all {
    outputs.all {
      val appName = project.property("APP_NAME") as String // 从 gradle.properties 获取 APP_NAME
      val versionName = flutter.versionName // 获取版本号
      val versionCode = flutter.versionCode // 获取版本代码（可选）
      val buildType = buildType.name // 获取构建类型（如 release 或 debug）
      (this as com.android.build.gradle.internal.api.BaseVariantOutputImpl).outputFileName =
        "${appName}_${android.defaultConfig.applicationId}_${versionName}.apk"
      true
    }
    true
  }
}
```

## 命令行构建

```bash
flutter build apk --release \
  --build-name=0.0.1 \
  --build-number=1
```

## 生成 apk: build/app/outputs/apk/release/smyze-clean_com.smyze.clean_0.0.1.apk
