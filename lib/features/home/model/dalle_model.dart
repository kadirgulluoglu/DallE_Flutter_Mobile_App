import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/base/base_model.dart';

part 'dalle_model.g.dart';

@HiveType(typeId: 1)
class DallEModel extends BaseModel {
  DallEModel({
    this.created,
    this.data,
    this.title,
  });
  @HiveField(0)
  String? title;
  @HiveField(1)
  int? created;
  @HiveField(2)
  final List<Images>? data;

  @override
  fromJson(Map<String, dynamic> json) => DallEModel(
        created: json["created"],
        data: List<Images>.from(json["data"].map((x) => Images.fromJson(x))),
      );

  @override
  Map<String, dynamic> toMap() => {
        "created": created,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 2)
class Images extends HiveObject {
  Images({
    this.url,
  });
  @HiveField(0)
  String? url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
