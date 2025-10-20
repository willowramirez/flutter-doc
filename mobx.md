# mobx 管理状态

## doc

- [Flutter 状态管理：使用 MobX](https://docs.flutter.cn/community/tutorials/flutter-state-management-with-mobx)
- [mobx 2.3.3+2](https://pub.dev/packages/mobx)

## 注意点

- 创造单例，跨页面共享状态
- 用 Observer(builder: (_) => Text('${xxStore.value}')) 监听状态
