# Niku

## 父样式

```dart
// 多属性
n.Text("Using useParent")
  ..useParent((v) => v
    ..p = 20
  );
// 单属性
n.Text("Using useParent")
  ..n.p = 20;
```

## 复用样式表

```dart
class ButtonStyle {
  static final confirm = n.Button("".n)
    ..bold
    ..fontSize = 24
    ..splash = Colors.blue.shade400
    ..bg = Colors.blue.shade50
    ..px = 16
    ..py = 8
    ..rounded = 8;
  // 动态
  static bg(Color color) => n.Button("".n)..bg = color;
  // 衍生
  static final extend = confirm
    .copied
    ..border = const BorderSide(width: 1);
  // 组合
  static final combine = n.Button("".n)
    ..use([
      confirm,
      bg(Colors.red),
    ]);
}

// ✅ This will apply all the styling with 1 line
n.Button("".n)
    ..apply = ButtonStyle.confirm;
    ..apply = ButtonStyle.bg(Colors.black)
```

## 性能调优

```dart
// 防止重新绘制
n.Box()
  ..freezed;

n.Box()
  ..deps = [
    color,
    expensiveState
  ];

// 防止内存分配，只有当状态改变时才分配
n.On(
  n.Box()
)
```

## 事件

```dart
n.Box()
  ..on(
    tap: () {}
  )
```

## Hooks

```dart
// ..useParent((v) => v..p=8)
// ..useQuery((v, query) {})
// ..useSize((v, size) {})
// ..useThemeSelector(
//   light: (v) => v..color = Colors.black,
//   dark: (v) => v..color = Colors.white,
// )
// ..usePlatform(
//   iOS: (a) => a..color = Colors.red,
//   android: (a) => a..color = Colors.blue,
// );
// [android, iOS, fuchsia, linux, macOS, windows, web]
// ..useTransition<Color>(
//   value: color,
//   builder: (child, value) => child..bg = value,
//   // Optional
//   duration: Duration(milliseconds: 200),
//   // Optional
//   curves: Curves.linear,
// );
```

## [小部件](https://m3.material.io/components/dialogs/overview)

- 网格视图

```dart
n.GridView.count()
  ..count = 3 // CrossAxisCount
  ..ratio = 1
  ..children = List.generate(
    5,
    (index) => index.toString().n
      ..fontSize = 50.sp
      ..useParent(
        (v) => v
          ..center
          ..bg = Colors.teal[300]!,
      ),
  )
  ..mainAxisSpacing = 30.sp
  ..crossAxisSpacing = 30.sp,
```

- 图标
  - [字体图标](https://fonts.google.com/icons)
