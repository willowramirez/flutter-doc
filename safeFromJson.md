# 接口返回数据正确性校验

[TOC]

## 代码

### 统一异常处理

```dart
// lib/utils/safe_from_json.dart

T safeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return fromJson(json);
  } catch (e, st) {
    L.e("safeFromJson $T", error: e, stackTrace: st);
    throw FormatException('Invalid JSON for $T: $e');
  }
}

```

### 泛型检查使用

```dart
_getInfo() async {
  try {
    // 1. 请求接口
    Response res = await api.getInfoApi();
    // 2. 安全解析 JSON，如果格式不符合要求会抛 FormatException
    final data = safeFromJson(res.data, InfoResponse.fromJson);
    // 3. 业务处理
  } on FormatException catch (e) {
    if (mounted) error(context, '数据格式错误：${e.message}');
  } on DioException catch (e) {
    // 5. 捕获请求错误
    L.e("_getInfo", error: e.toString());
    if (mounted) error(context, e.message ?? '未知错误');
  } catch (e, st) {
    // 6. 捕获其他未预料的错误
    L.e("_getInfo", error: e.toString(), stackTrace: st);
    if (mounted) error(context, '发生未知错误');
  } finally {}
}
```

## 错误示例

```bash
# 必传字段未返回
FormatException: Invalid JSON for InfoResponse: type 'Null' is not a subtype of type 'num' in type cast

# 字段返回类型错误
FormatException: Invalid JSON for InfoResponse: type 'String' is not a subtype of type 'num?' in type cast

# stackTrace 会指向具体到 model/xxx/index.g.dart:53:27 告诉你那个字段配置与接口返回的数据类型不一致
```
