bool checkPattern({required String pattern, required String value}) {
  final regularCheck = RegExp(pattern);
  return regularCheck.hasMatch(value);
}

elseNull<T>({required bool condition, required T child}) {
  return condition ? child : null;
}
