import 'dart:convert';
import '../api_path.dart';

class PostModel {
  final int id;
  List<String> _images = [];
  final String title;
  final String content;
  final DateTime createdAt;

  int viewCount = 0;
  int likeCount = 0;
  int shareCount = 0;

  get images => _images;
  get image => _images.isEmpty ? null : _images.first;

  PostModel({
    required this.id,
    required images,
    required this.title,
    required this.content,
    required this.viewCount,
    required this.likeCount,
    required this.shareCount,
    required this.createdAt,
  }) : _images = List<String>.from(
            images.map((e) => ApiPath.imageUrl + e.toString()).toList());

  factory PostModel.fromMap(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      images: jsonDecode(json['images']),
      title: json['title'],
      content: json['content'],
      viewCount: json['viewCount'],
      likeCount: json['likeCount'],
      shareCount: json['shareCount'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory PostModel.empty() {
    return PostModel(
      id: 0,
      images: [],
      title: 'Empty',
      content: 'Empty',
      viewCount: 0,
      likeCount: 0,
      shareCount: 0,
      createdAt: DateTime.now(),
    );
  }
}
