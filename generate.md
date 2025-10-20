# 数据类 / 联合体 / 模式匹配 / 克隆的代码生成器

[TOC]

## 文档

[freezed](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md)

## 背景

定义模型复杂

1. 定义一个构造函数+属性
2. 覆写 `toString`, `operator ==`, `hashCode`
3. 实现 `copyWith` 方法来克隆对象
4. 处理数据（反）序列化

## 配置指南

### 1. 安装

```bash
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
# 如果你要使用 freezed 来生成 fromJson/toJson，则执行：
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

### 2. 禁用 invalid_annotation_target 警告

```yaml
# analysis_options.yaml

analyzer:
  errors:
    invalid_annotation_target: ignore
```

### 3. 运行生成器

```bash
dart run build_runner build
```

### 4. 创建文件 file.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 必要的：关联 `file.dart` 到 Freezed 代码生成器
part 'file.freezed.dart';
// 可选的：因为 Person 类是可序列化的，所以我们必须添加这一行。
// 但是如果 Person 不是可序列化的，我们可以跳过它。
part 'file.g.dart';

@freezed
// @unfreezed 可变类
// @Freezed(
//   makeCollectionsUnmodifiable: false, 使类型为 List/Map/Set 的属性可变
//   copyWith: false, 禁用生成 copyWith
//   equal: false, 禁用生成 ==
// )
abstract class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

### 4. 工具

- [从 JSON 数据生成 Freezed 类](https://dartj.web.app/)
