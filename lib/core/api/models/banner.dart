import '../api_path.dart';

class Banner {
  final int id;
  late final String _image;
  final String payload;
  final String keywords;

  set image(value) => _image = value;
  get image => ApiPath.imageUrl + _image;

  Banner({
    required this.id,
    required image,
    required this.payload,
    required this.keywords,
  }) : _image = image;

  factory Banner.fromMap(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      image: json['image'],
      payload: json['payload'],
      keywords: json['keywords'],
    );
  }
}
