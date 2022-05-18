import '../api_path.dart';

class UserModel {
  final int id;
  final String username;
  final String phoneNumber;
  String? _image;
  final String? about;
  final String? partnerType;
  final String? status;
  final String? statusEndTime;
  final String? createdAt;
  final String? loggedAt;
  // final String? updatedAt;

  final int? followerCount;
  final int? followingCount;
  final int? albumCount;
  final int? postCount;
  final int? videoCount;
  final int? viewCount;

  get image => _image;
  _setImage(String? image) {
    if (image != null) {
      _image = ApiPath.imageUrl + image;
    }
  }

  UserModel({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required String image,
    required this.about,
    required this.partnerType,
    required this.status,
    required this.statusEndTime,
    required this.createdAt,
    required this.loggedAt,
    required this.followerCount,
    required this.followingCount,
    required this.albumCount,
    required this.postCount,
    required this.videoCount,
    required this.viewCount,
  }) {
    _setImage(image);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      image: map['image'],
      about: map['about'],
      partnerType: map['partnerType'],
      status: map['status'],
      statusEndTime: map['statusEndTime'],
      createdAt: map['createdAt'],
      loggedAt: map['loggedAt'],
      followerCount: map['followerCount'],
      followingCount: map['followingCount'],
      albumCount: map['albumCount'],
      postCount: map['postCount'],
      videoCount: map['videoCount'],
      viewCount: map['viewCount'],
    );
  }
}
