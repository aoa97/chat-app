import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get mqw => MediaQuery.of(this).size.width;
  double get mqh => MediaQuery.of(this).size.height;
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension SpacesExtension on num {
  SizedBox get spw => SizedBox(width: toDouble());
  SizedBox get sph => SizedBox(height: toDouble());
}
