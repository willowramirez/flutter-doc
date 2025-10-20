# redux 管理状态

## 文档

- [redux](https://pub.dev/packages/redux)

## 使用

1. 创建state `lib/redux/state.dart`

```dart
class AppState {
  int count = 0;

  AppState({
    required this.count,
  });

  AppState copyWith({
    required int count,
  }) {
    return AppState(
      count: count,
    );
  }
}


```

2. 创建action `lib/redux/action.dart`

```dart
class IncrementAction {
  int count;
  IncrementAction(this.count);
}
```

3. 创建reducer `lib/redux/reducer.dart`

```dart
import 'action.dart';
import 'state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is IncrementAction) {
    return state.copyWith(
      count: action.count,
    );
  }

  return state;
}

```

4. 创建store `lib/redux/store.dart`

```dart
import 'package:redux/redux.dart';

import 'reducer.dart';
import 'state.dart';

final store = Store<AppState>(
  reducer,
  initialState: AppState(
    count: 0,
  ),
);
```

5. 根节点绑定 store`lib/main.dart`

```dart
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: Home(),
        ),
      ),
    );
  }
```

6. 子组件使用store

```dart
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return Row(
          children: [
            Text(store.state.count.toString()), // 使用状态
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => store.dispatch(
                IncrementAction(1),
              ), // 更细状态
            ),
          ],
        );
      },
    );
  }
```
