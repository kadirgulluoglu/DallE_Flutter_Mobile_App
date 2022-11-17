import 'package:hive_flutter/hive_flutter.dart';

abstract class ICacheManagerHive<T> {
  final String key;
  Box<T>? _box;
  Box<T>? get box => _box;
  ICacheManagerHive(this.key);
  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(key);
    }
  }

  void registerAdapters();

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> addItem(T item);
  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);

  T? getItem(String key) {
    return _box?.get(key);
  }

  List<T>? getValues() {
    return _box?.values.toList();
  }

  Future<void> putItem(String key, T item);
  Future<void> removeItem(String key);
}
