import 'package:dio/dio.dart';

import '../../base/base_model.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance => _instance ??= NetworkManager._init();

  Dio _dio = Dio();
  NetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: "https://api.openai.com");
    _dio = Dio(baseOptions);
  }

  Future<dynamic> dioGet<T extends BaseModel>(String path,
      {T? model,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.get(path,
        options: options, queryParameters: queryParameters);

    switch (response.statusCode) {
      case 200:
        final responseBody = response.data;
        if ((responseBody is List) && model != null) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if ((responseBody is Map) && model != null) {
          return model.fromJson(responseBody as Map<String, dynamic>);
        } else {
          return responseBody;
        }
      default:
    }
  }

  Future<dynamic> dioPost<T extends BaseModel>(String path,
      {T? model, dynamic data, Options? options}) async {
    Response response = await _dio.post(path, options: options, data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.data;
      if ((responseBody is List) && model != null) {
        return responseBody.map((e) => model.fromJson(e)).toList();
      } else if ((responseBody is Map) && model != null) {
        return model.fromJson(responseBody as Map<String, dynamic>);
      } else {
        return responseBody;
      }
    }
  }

  Future<dynamic> dioPatch<T extends BaseModel>(String path,
      {T? model, dynamic data, Options? options}) async {
    Response response = await _dio.patch(path, options: options, data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.data;
      if ((responseBody is List) && model != null) {
        return responseBody.map((e) => model.fromJson(e)).toList();
      } else if ((responseBody is Map) && model != null) {
        return model.fromJson(responseBody as Map<String, dynamic>);
      } else {
        return responseBody;
      }
    }
  }

  Future<dynamic> dioDelete<T extends BaseModel>(String path,
      {T? model, dynamic data, Options? options}) async {
    Response response = await _dio.delete(path, options: options, data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.data;
      if ((responseBody is List) && model != null) {
        return responseBody.map((e) => model.fromJson(e)).toList();
      } else if ((responseBody is Map) && model != null) {
        return model.fromJson(responseBody as Map<String, dynamic>);
      } else {
        return responseBody;
      }
    }
  }
}
