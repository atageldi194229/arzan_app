import 'dart:convert';
import 'package:flutter/material.dart';

import '../api_path.dart';

class PostModel {
  final int id;
  List<String> _images = [];
  final String title;
  final String content;
  final DateTime createdAt;
  List<String> contacts;

  int viewCount = 0;
  int likeCount = 0;
  int shareCount = 0;
  bool isLike;
  bool isFavorite;

  get images => _images;
  get image => _images.isEmpty ? null : _images.first;

  static T tryCatch<T>(T Function() fn, T defaultValue) {
    try {
      return fn();
    } catch (err) {
      debugPrint(err.toString());
      return defaultValue;
    }
  }

  static bool getBoolValue(
    String key,
    Map<String, dynamic> map, [
    bool defaultValue = false,
  ]) {
    if (map.containsKey(key)) {
      if (map[key].runtimeType == int) return map[key] == 1;
      if (map[key].runtimeType == String) return map[key] == '1';
      if (map[key].runtimeType == bool) return map[key];
    }

    return defaultValue;
  }

  PostModel({
    required this.id,
    required List<String> images,
    required this.title,
    required this.content,
    required this.viewCount,
    required this.likeCount,
    required this.shareCount,
    required this.createdAt,
    this.contacts = const [],
    this.isLike = false,
    this.isFavorite = false,
  }) : _images =
            images.map<String>((e) => ApiPath.imageUrl + e.toString()).toList();

  factory PostModel.fromMap(Map<String, dynamic> json) {
    // debugPrint(json['contacts']);

    var contacts = tryCatch<List<String>>(
        () => List<String>.from(jsonDecode(json['contacts'])), []);

    var images = tryCatch<List<String>>(
        () => List<String>.from(jsonDecode(json['images'])), []);

    bool isLike = getBoolValue('isLike', json);
    bool isFavorite = getBoolValue('isFavorite', json);

    return PostModel(
      id: json['id'],
      images: images,
      title: json['title'],
      content: json['content'],
      viewCount: json['viewCount'],
      likeCount: json['likeCount'],
      shareCount: json['shareCount'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
      contacts: contacts,
      isLike: isLike,
      isFavorite: isFavorite,
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
