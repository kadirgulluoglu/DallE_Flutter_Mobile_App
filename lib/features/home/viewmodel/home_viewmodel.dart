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
  final String apiKey = "YOUR API KEY";
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
          prompt: typeList[selectedTypeIndex].text! + translationPrompt.text,
          apiKey: apiKey);

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
      title: "Filtresiz",
      icon: Icons.nearby_off,
      text: "",
      isSelected: true,
    ),
    ImageTypeModel(
      title: "3D Render",
      icon: Icons.animation,
      text: "3D Render Of",
    ),
    ImageTypeModel(
      title: "Dijital",
      icon: Icons.nature,
      text: "Digital Art",
    ),
    ImageTypeModel(
      title: "Neon",
      icon: Icons.light,
      text: "A futuristic neon of",
    ),
    ImageTypeModel(
      title: "Pastel",
      icon: Icons.invert_colors_on,
      text: "An oil pastel drawing of",
    ),
    ImageTypeModel(
      title: "Kara Kalem",
      icon: Icons.border_color,
      text: "A hand drawn sketch",
    ),
  ];

  int _selectedTypeIndex = 0;

  int get selectedTypeIndex => _selectedTypeIndex;

  set selectedTypeIndex(int value) {
    _selectedTypeIndex = value;
    notifyListeners();
  }

  void changeSelected(int index) {
    for (int i = 0; i < typeList.length; i++) {
      typeList[i].isSelected = false;
    }
    typeList[index].isSelected = true;
    selectedTypeIndex = index;
  }
}
