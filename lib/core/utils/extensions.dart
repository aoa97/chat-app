import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get mqw => MediaQuery.of(this).size.width;
  double get mqh => MediaQuery.of(this).size.height;
  ColorScheme get colors => Theme.of(this).colorScheme;
  Future push(Widget screen) => Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
  Future pushNamed(String path, {Object? args}) => Navigator.of(this).pushNamed(path, arguments: args);
  void pop() => Navigator.of(this).pop();
  bool get canPop => Navigator.of(this).canPop();
}

extension NullableExtensions<T> on T? {
  R? elseNull<R>(R Function(T) op) {
    if (this != null) {
      return op(this as T);
    }
    return null;
  }
}
