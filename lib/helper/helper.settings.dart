import 'package:katakara_investor/helper/helper.local.storage.dart';
import 'package:katakara_investor/models/register/register.dart';
import 'package:katakara_investor/values/values.dart';

class AppSettings {
  static bool? isLogin;

  static init() async {
    await AppStorage.initStorage(storageName: StorageNames.settings.name);
    final userInfo = await AppStorage.readData(
            storageName: StorageNames.settings.name,
            key: SettingsKey.user.name) ??
        null;
    if (userInfo != null) userData = UserDataModel.fromJson(userInfo);
    isLogin = await AppStorage.readData(
            storageName: StorageNames.settings.name,
            key: SettingsKey.isLogin.name) ??
        false;
  }

  static saveUserToLocal(dynamic value) async {
    await AppStorage.saveData(
      storageName: StorageNames.settings.name,
      key: SettingsKey.user.name,
      value: value,
    );
  }
}
