import '../api_path.dart';

class BannerModel {
  final int id;
  late final String _image;
  final String payload;
  final String keywords;

  set image(value) => _image = value;
  get image => ApiPath.imageUrl + _image;

  BannerModel({
    required this.id,
    required image,
    required this.payload,
    required this.keywords,
  }) : _image = image;

  factory BannerModel.fromMap(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
      payload: json['payload'],
      keywords: json['keywords'],
    );
  }
}
