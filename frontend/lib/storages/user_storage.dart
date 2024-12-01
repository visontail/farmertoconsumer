import 'package:farmertoconsumer/storages/common/storage_item.dart';

class UserStorage {
  static final UserStorage _instance = UserStorage._internal();
  UserStorage._internal();

  factory UserStorage() {
    return _instance;
  }

  StorageItem<String> token = StorageItem<String>();
}