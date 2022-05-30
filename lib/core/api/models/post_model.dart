import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/user_action.dart';
import 'package:tm/core/api/services/user_action_service.dart';

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

  static ifExists(Map map, String key, dynamic defaultValue) {
    if (map.containsKey(key)) return map[key];
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
      viewCount: ifExists(json, 'viewCount', 0),
      likeCount: ifExists(json, 'likeCount', 0),
      shareCount: ifExists(json, 'shareCount', 0),
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

  favoriteIt({
    Function? notify,
  }) {
    bool isFavorite = this.isFavorite;
    this.isFavorite = !isFavorite;

    if (notify != null) notify();

    var userAction = UserAction(
      id: id,
      count: isFavorite ? -1 : 1,
      type: UserActionModel.post,
      action: UserActionType.favorite,
    );

    UserActionService().createUserAction(userAction).catchError((_) {
      this.isFavorite = isFavorite;
      if (notify != null) notify();
    });
  }

  shareIt({Function? notify}) {
    shareCount++;
    if (notify != null) notify();

    var userAction = UserAction(
      id: id,
      count: 1,
      type: UserActionModel.post,
      action: UserActionType.share,
    );

    UserActionService().createUserAction(userAction).catchError((_) {
      shareCount--;
      if (notify != null) notify();
    });
  }

  likeIt({Function? notify}) {
    bool isLike = this.isLike;
    likeCount++;
    this.isLike = true;

    if (notify != null) notify();

    var userAction = UserAction(
      id: id,
      count: 1,
      type: UserActionModel.post,
      action: UserActionType.like,
    );

    UserActionService().createUserAction(userAction).catchError((_) {
      likeCount--;
      this.isLike = isLike;

      if (notify != null) notify();
    });
  }

  viewIt({Function? notify}) {
    viewCount++;
    if (notify != null) notify();

    var userAction = UserAction(
      id: id,
      count: 1,
      type: UserActionModel.post,
      action: UserActionType.view,
    );

    UserActionService().createUserAction(userAction).catchError((_) {
      viewCount--;
      if (notify != null) notify();
    });
  }
}
