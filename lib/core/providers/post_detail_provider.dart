import 'package:tm/core/api/services/user_action_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

class PostDetailProvider extends ChangeNotifier {
  models.Post _post = models.Post.empty();

  get post => _post;

  set post(value) {
    _post = value;
    notifyListeners();

    UserActionService()
        .createUserAction(
          models.UserAction(
            id: _post.id,
            count: 1,
            type: models.UserActionModel.post,
            action: models.UserActionType.view,
          ),
        )
        .catchError((error) => Future.value(false));
  }
}
