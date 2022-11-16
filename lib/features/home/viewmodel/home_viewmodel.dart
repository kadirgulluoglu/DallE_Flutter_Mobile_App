import 'package:dalle_flutter_mobile_app/features/home/model/dalle_model.dart';
import 'package:dalle_flutter_mobile_app/features/home/service/home_service.dart';
import 'package:dalle_flutter_mobile_app/product/enum/view_state.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel with ChangeNotifier {
  final HomeService _service = HomeService.instance;
  final String apiKey = "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";

  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }
  // } try {
  // DallEModel? dale;
  // final HomeService _service = HomeService.instance;
  // } on DioError catch (e) {
  // print(e);
  // }

  DallEModel? dallEModel;

  Future getImage({required String prompt}) async {
    try {
      state = ViewState.busy;
      dallEModel = await _service.getImage(prompt: prompt, apiKey: apiKey);
      state = ViewState.idle;
    } catch (e) {
      state = ViewState.error;
      print(e);
    }
  }
}
