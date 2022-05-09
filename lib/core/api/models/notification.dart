import '../api_path.dart';

class NotificationModel {
  final int id;
  late final String _image;
  final String payload;
  final String title;
  final String content;
  final String type;
  final String createdAt;

  set image(value) => _image = value;
  String get image => ApiPath.imageUrl + _image;

  NotificationModel({
    required this.id,
    required image,
    required this.payload,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
  }) : _image = image;

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      image: json['image'],
      payload: json['payload'],
      title: json['title'],
      content: json['content'],
      type: json['type'],
      createdAt: json['createdAt'],
    );
  }
}
