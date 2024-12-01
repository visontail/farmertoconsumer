import 'package:farmertoconsumer/models/authenticated_user.dart';
import 'package:farmertoconsumer/storages/common/storage_item.dart';

class WriteableUserStorage {
  static final WriteableUserStorage _instance =
      WriteableUserStorage._internal();
  WriteableUserStorage._internal();

  factory WriteableUserStorage() {
    return _instance;
  }

  WriteableStorageItem<String> token = WriteableStorageItem<String>();
  WriteableStorageItem<AuthenticatedUser> user =
      WriteableStorageItem<AuthenticatedUser>();
}

class UserStorage {
  static final UserStorage _instance = UserStorage._internal();
  UserStorage._internal();

  factory UserStorage() {
    return _instance;
  }

  StorageItem<String> token = StorageItem(WriteableUserStorage().token);
  StorageItem<AuthenticatedUser> user =
      StorageItem(WriteableUserStorage().user);
}
