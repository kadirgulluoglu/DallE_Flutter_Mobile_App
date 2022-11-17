import 'package:dalle_flutter_mobile_app/features/home/model/dalle_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive/i_cache_manager_hive.dart';

class ImageCacheManager extends ICacheManagerHive<DallEModel> {
  ImageCacheManager(super.key);

  @override
  Future<void> addItems(List<DallEModel> items) async {
    await box?.addAll(items);
  }

  @override
  Future<void> putItem(String key, item) async {
    await box?.put(key, item);
  }

  @override
  Future<void> putItems(List<DallEModel> items) async {}

  @override
  Future<void> removeItem(String key) async {
    box?.delete(key);
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DallEModelAdapter());
      Hive.registerAdapter(ImagesAdapter());
    }
  }

  @override
  List<DallEModel>? getValues() {
    return box?.values.toList();
  }

  @override
  Future<void> addItem(DallEModel item) async {
    await box?.add(item);
  }

  @override
  Future<void> clearAll() async {
    await box?.clear();
  }
}
