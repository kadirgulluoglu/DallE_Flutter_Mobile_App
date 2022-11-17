import 'package:dalle_flutter_mobile_app/cache/managers/image_cache_manager.dart';
import 'package:dalle_flutter_mobile_app/features/home/model/dalle_model.dart';
import 'package:dalle_flutter_mobile_app/features/home/model/image_type_model.dart';
import 'package:dalle_flutter_mobile_app/features/home/service/home_service.dart';
import 'package:dalle_flutter_mobile_app/product/enum/view_state.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../cache/hive/i_cache_manager_hive.dart';
import '../../../product/enum/cache_status_enum.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    initial();
  }

  Future initial() async {
    _cacheManager = ImageCacheManager("images");
    await _cacheManager.init();
    controlCache();
  }

  final HomeService _service = HomeService.instance;
  final String apiKey = "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";
  final translator = GoogleTranslator();

  ViewState _state = ViewState.error;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  DallEModel? dallEModel;
  DallEModel? historyDallEModel;
  DallEModel? tempDallEModel;

  Future getImage({required String prompt}) async {
    try {
      state = ViewState.busy;
      var translationPrompt =
          await translator.translate(prompt, from: 'tr', to: 'en');
      dallEModel = await _service.getImage(
          prompt: translationPrompt.text, apiKey: apiKey);
      await createHistoryImageModel(dallEModel?.data ?? [], prompt);

      state = ViewState.idle;
    } catch (e) {
      state = ViewState.error;
    }
  }

  late final ICacheManagerHive<DallEModel> _cacheManager;

  CacheStatus _cacheStatus = CacheStatus.notHave;
  CacheStatus get cacheStatus => _cacheStatus;
  set cacheStatus(CacheStatus cacheStatus) {
    _cacheStatus = cacheStatus;
    notifyListeners();
  }

  Future<void> createHistoryImageModel(
      List<Images> imageUrl, String? title) async {
    await _cacheManager.addItem(DallEModel(data: imageUrl, title: title));
    controlCache();
  }

  List<DallEModel>? modelList;
  Future<void> controlCache() async {
    modelList = _cacheManager.getValues();
    if (modelList?.isNotEmpty ?? false) {
      cacheStatus = CacheStatus.available;
    } else {
      cacheStatus = CacheStatus.notHave;
    }
  }

  //const List
  List<ImageTypeModel> typeList = [
    ImageTypeModel(
      title: "Boş",
      icon: Icons.hourglass_empty,
      text: "",
    ),
    ImageTypeModel(
      title: "3D Render",
      icon: Icons.animation,
      text: "3D Render Of",
    ),
    ImageTypeModel(
      title: "Dijital",
      icon: Icons.nature,
      text: "3D Render Of",
    ),
    ImageTypeModel(
      title: "3D Render",
      icon: Icons.animation,
      text: "3D Render Of",
    ),
  ];

  void changeSelected(int index) {
    for (int i = 0; i < typeList.length; i++) {
      typeList[i].isSelected = false;
    }
    typeList[index].isSelected = true;
    notifyListeners();
  }
}
