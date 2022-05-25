class RegionStatusModel {
  int? id;
  String? name;
  int? order;
  Month? month;
  Month? week;
  Month? day;

  var date;

  RegionStatusModel(
      {this.id, this.name, this.order, this.month, this.week, this.day});

  RegionStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    month = json['month'] != null ? new Month.fromJson(json['month']) : null;
    week = json['week'] != null ? new Month.fromJson(json['week']) : null;
    day = json['day'] != null ? new Month.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    if (this.month != null) {
      data['month'] = this.month!.toJson();
    }
    if (this.week != null) {
      data['week'] = this.week!.toJson();
    }
    if (this.day != null) {
      data['day'] = this.day!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postCount'] = this.postCount;
    data['viewCount'] = this.viewCount;
    data['shareCount'] = this.shareCount;
    data['likeCount'] = this.likeCount;
    return data;
  }
}
