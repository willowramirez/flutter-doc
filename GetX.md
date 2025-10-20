# GexX 管理状态

## 文档

- [GetX](https://pub.dev/packages/getx)

## 使用

- 顶层注入 store

```dart
// Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());
```

- 子组件捕获 store

```dart
final Controller c = Get.find();
```

- 子组件使用状态

```dart
Obx(() => Text('${c.count}')),
```
