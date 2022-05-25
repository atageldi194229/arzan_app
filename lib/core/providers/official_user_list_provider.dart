import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/user_service.dart';
import 'package:tm/core/providers/abstract/item_list_provider.dart';

class OfficialUserListProvider extends ItemListProvider<UserModel> {
  @override
  Future<List<UserModel>> fetchItems(int limit, int offset) {
    return UserService().getOfficials(limit: limit, offset: offset);
  }
}
