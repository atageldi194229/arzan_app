import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/core/api/models/user_action.dart';
import 'package:tm/core/api/services/user_action_service.dart';
import 'package:flutter/material.dart';

class PostDetailProvider extends ChangeNotifier {
  PostModel _post = PostModel.empty();

  get post => _post;

  set post(value) {
    _post = value;
    notifyListeners();

    UserActionService()
        .createUserAction(
          UserAction(
            id: _post.id,
            count: 1,
            type: UserActionModel.post,
            action: UserActionType.view,
          ),
        )
        .catchError((error) => Future.value(false));
  }
}
