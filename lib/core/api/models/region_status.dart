class RegionStatusModel {
  int? id;
  String? name;
  int? order;
  Month? month;
  Month? week;
  Month? day;

  RegionStatusModel(
      {this.id, this.name, this.order, this.month, this.week, this.day});

  RegionStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    month = json['month'] != null ? Month.fromJson(json['month']) : null;
    week = json['week'] != null ? Month.fromJson(json['week']) : null;
    day = json['day'] != null ? Month.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    if (month != null) {
      data['month'] = month!.toJson();
    }
    if (week != null) {
      data['week'] = week!.toJson();
    }
    if (day != null) {
      data['day'] = day!.toJson();
    }
    return data;
  }
}

class Month {
  int? postCount;
  int? viewCount;
  int? shareCount;
  int? likeCount;

  Month({this.postCount, this.viewCount, this.shareCount, this.likeCount});

  Month.fromJson(Map<String, dynamic> json) {
    postCount = json['postCount'];
    viewCount = json['viewCount'];
    shareCount = json['shareCount'];
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postCount'] = postCount;
    data['viewCount'] = viewCount;
    data['shareCount'] = shareCount;
    data['likeCount'] = likeCount;
    return data;
  }
}
