
import '../../../core/base/base_model.dart';

class DallEModel extends BaseModel {
  DallEModel({
    this.created,
    this.data,
  });

  int? created;
  List<Images>? data;

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

class Images {
  Images({
    this.url,
  });

  String? url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
