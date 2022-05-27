enum UserActionType { view, like, share, favorite, follow }

enum UserActionModel { post, banner, user }

class UserAction {
  final UserActionType action;
  final UserActionModel type;
  final int id;
  final int count;

  UserAction({
    required this.id,
    required this.type,
    required this.action,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      "relId": id,
      "type": type.name,
      "action": action.name,
      "count": count,
    };
  }
}
