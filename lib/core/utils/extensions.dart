import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get mqw => MediaQuery.of(this).size.width;
  double get mqh => MediaQuery.of(this).size.height;
  ColorScheme get colors => Theme.of(this).colorScheme;
  Future<T?> push<T>(Widget screen) => Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
  void pop() => Navigator.of(this).pop();
  bool get canPop => Navigator.of(this).canPop();
}
